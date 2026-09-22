# ArtInspector 0.1.2 checker materials

This folder contains the eleven supplied HLSL checkers. Select a checker in the
application and adjust its generated parameter controls. F5 reloads materials;
file changes are also detected automatically. Refresh clears the scene and resets
checker parameters. Selecting a checker preserves the current Lit/Unlit state.

## Creating a material for your own use

Implement the host entry point:

```hlsl
//@name My Checker
//@description Custom diagnostic material.
//@order 50
//@param float Scale|Checker scale|1|256|32
//@param color Tint|Tint color|0.1|0.6|1.0
float3 MaterialMain(PSInput input, bool isFrontFace)
{
    float checker = fmod(floor(input.UV.x * Scale) + floor(input.UV.y * Scale), 2.0);
    return lerp(Tint * 0.15, Tint, checker);
}
```

The current legacy host supports up to 64 parameter slots and choice parameters.
The compact GLSL-like input accepts vec2/3/4, mix, fract, dFdx and dFdy and translates
them to HLSL; it is not a general OpenGL/GLSL renderer. HLSL is used for the shipped
materials. Input fields include WorldPosition, Normal, UV, MaterialColor,
VertexColor, UvPerMeter, Flags and the host-provided WireBarycentric.
FilteredChecker(float2 uv) supplies a filtered checker helper.

Solid Wireframe uses barycentrics assigned by the 0.1.2 host, not UV coordinates.
Emissive is supported; Bloom is not. Shader reload keeps compatible parameter
values; use reset controls to restore shader defaults. A shader that requires
new host fields cannot simply be installed into an older executable.

These instructions describe 0.1.2, not the earlier v0.1.0 RAR. Preserve your own
modified shaders before replacing a package. See [license terms](../../LICENSE.md),
[third-party notices](../../licenses/THIRD_PARTY_NOTICES.md) and
[provenance review](../../docs/licensing/ARTINSPECTOR_PROVENANCE.md).
