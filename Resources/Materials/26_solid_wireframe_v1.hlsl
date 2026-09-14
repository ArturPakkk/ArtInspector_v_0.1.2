//@name Solid Wireframe v1
//@description Opaque triangle faces with anti-aliased mesh edges. Requires PSInput.WireBarycentric supplied by the renderer; this is not a UV grid or hardware wireframe mode.
//@order 26
//@unlit
//@geometry solid-wireframe
//@category Lines
//@param float WireWidth|Line width (px)|0.5|6|1.25
//@param float WireSoftness|Line softness (px)|0.5|2|1
//@param float WireStrength|Line strength|0|1|1
//@param color WireColor|Line color|0.025|0.025|0.025
//@category Surface
//@param float SurfaceShading|Surface shading|0|1|0.35
//@param color SurfaceColor|Surface color|0.42|0.42|0.42

// NEW INPUT CONTRACT -- MUST BE CONNECTED ONCE IN THE APPLICATION:
//     noperspective float3 WireBarycentric : WIREFRAME_BARYCENTRIC0;
// The three corners of EACH rendered triangle receive (1,0,0), (0,1,0),
// (0,0,1). Do not derive this from UV, and do not use VertexID % 3 on an
// arbitrary indexed mesh. The supplied C++ helper expands an indexed mesh
// without changing the original asset. See README_RU.md.
//
// REQUIRED PIPELINE: filled triangles, depth test and depth write enabled,
// opaque blend state, output alpha = 1. The material does not change PSO state.
// There is NO transparency, clip/discard, separate line pass, or depth bias.
// Draw the surface and its wire color in the SAME pass.
//
// WireWidth is the nominal full width across a shared edge. Only the half
// inside this triangle can be drawn. Boundary/silhouette lines are one-sided.
// This displays render TRIANGLES, including triangulation diagonals.
// No claim is made to reconstruct original quads/ngons from triangle data.

float SWFv1_FiniteOr(float value, float fallback)
{
    return isfinite(value) ? value : fallback;
}

float3 SWFv1_ColorOr(float3 value, float3 fallback)
{
    return all(isfinite(value)) ? saturate(value) : fallback;
}

bool SWFv1_TryNormalize(float3 value, out float3 direction)
{
    direction = float3(0.0, 0.0, 0.0);
    if (!all(isfinite(value)))
        return false;

    float scale = max(abs(value.x), max(abs(value.y), abs(value.z)));
    if (!(scale > 0.0))
        return false;

    float3 scaled = value / scale;
    float len2 = dot(scaled, scaled);
    if (!(len2 > 0.0) || !isfinite(len2))
        return false;

    direction = scaled * rsqrt(len2);
    return true;
}

float3 MaterialMain(PSInput input, bool isFrontFace)
{
    // All screen derivatives precede every potentially divergent return.
    // Do NOT saturate barycentrics before taking derivatives.
    float3 bary = input.WireBarycentric;
    float3 dbdx = ddx(bary);
    float3 dbdy = ddy(bary);

    float3 faceColor = SWFv1_ColorOr(SurfaceColor, float3(0.42, 0.42, 0.42));
    float3 lineColor = SWFv1_ColorOr(WireColor, float3(0.025, 0.025, 0.025));

    // Magenta denotes a broken barycentric input contract, NOT a UV issue.
    const float3 BadBarycentricColor = float3(1.0, 0.0, 0.75);
    if (!all(isfinite(bary)) || !all(isfinite(dbdx)) || !all(isfinite(dbdy)))
        return BadBarycentricColor;
    if (abs(bary.x + bary.y + bary.z - 1.0) > 0.02)
        return BadBarycentricColor;

    // Per-component Euclidean screen gradient. Unlike abs(ddx)+abs(ddy),
    // this does not systematically thicken diagonally oriented edges.
    // Common scaling of each (dx,dy) pair avoids squaring huge gradients.
    float3 scale = max(abs(dbdx), abs(dbdy));
    if (any(scale <= 0.0))
        return BadBarycentricColor;

    float3 dxUnit = dbdx / scale;
    float3 dyUnit = dbdy / scale;
    float3 gradUnit = sqrt(dxUnit * dxUnit + dyUnit * dyUnit);

    // For affine/noperspective barycentrics: distance_i = bary_i / |grad_i|.
    // This is the perpendicular distance to each triangle edge, in pixels.
    // Negative extrapolated values at partially covered MSAA pixels are
    // treated as being on an edge; rasterization still controls coverage.
    float3 edgeDistance = (max(bary, 0.0) / scale) / gradUnit;
    float distancePx = min(edgeDistance.x, min(edgeDistance.y, edgeDistance.z));
    if (!isfinite(distancePx))
        return BadBarycentricColor;

    float widthPx = clamp(SWFv1_FiniteOr(WireWidth, 1.25), 0.5, 6.0);
    float softnessPx = clamp(SWFv1_FiniteOr(WireSoftness, 1.0), 0.5, 2.0);
    float strength = saturate(SWFv1_FiniteOr(WireStrength, 1.0));
    float halfWidth = 0.5 * widthPx;
    float halfSoftness = 0.5 * softnessPx;
    float edgeMask = 1.0 - smoothstep(halfWidth - halfSoftness,
                                      halfWidth + halfSoftness, distancePx);
    edgeMask *= strength;

    // Optional local headlight shading only for reading the solid shape.
    // It is unrelated to UV, scene lights, and the line thickness.
    // CameraPosition is part of the existing Shading Checker contract.
    float shadeStrength = saturate(SWFv1_FiniteOr(SurfaceShading, 0.35));
    float shade = 1.0;
    float3 N;
    float3 V;
    bool normalOK = SWFv1_TryNormalize(input.Normal, N);
    bool viewOK = SWFv1_TryNormalize(CameraPosition.xyz - input.WorldPosition, V);
    if (normalOK && viewOK)
    {
        float facing = saturate(abs(dot(N, V)));
        shade = lerp(1.0, 0.45 + 0.55 * sqrt(facing), shadeStrength);
    }

    // Flags and UvPerMeter are intentionally ignored. Missing UVs must NOT
    // hide real geometric edges, and vertex colors are left untouched.
    // WireStrength blends COLORS, never opacity.
    return lerp(faceColor * shade, lineColor, saturate(edgeMask));
}
