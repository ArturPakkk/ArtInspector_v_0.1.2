# Historical releases and licensing supplements

Audit: 2026-09-22. Original commits and tags are preserved.
The formal LICENSE.md was added at ae9573b, after both releases. Updated terms
have an explicit 2026-09-22 effective date and preserve prior applicable grants;
no claim is made that the file existed in earlier snapshots.

| Release | Tag commit | Original asset | Original licensing bundle |
| --- | --- | --- | --- |
| v0.1.0 | f74f515d19cc4dfd07e2e97241e7be837f220d21 | ArtInspector-0.1.0-win64.rar | Absent |
| 0.1.2 | 1688ce0dcabc563208faec3e676ff4aeb7e8cd3d | ArtInspector_v0.1.2.rar | Absent |

The extra Checker tag remains at 75e31e2434e351c965fd87ab4ff1bf42b96554a4;
there is no GitHub Release object for it. Exactly two release objects were
returned by the public API during this audit. Neither description contained a
licensing notice. The [prepared notice](LEGACY_RELEASE_NOTICE.md) is a draft for
appending after the associated documentation is published, not a claim that the
release descriptions have already been edited.

## Original uploaded executable hashes

| RAR | Executable | SHA-256 |
| --- | --- | --- |
| v0.1.0 | TexelDensityInspector.exe | f68bd6fc8e8cbb69343440042889756064f9532913edb0ead4e5fde89cdcec9e |
| 0.1.2 | ArtInspector/ArtInspector.exe | 3151308befcc68bdc623b22f2458ed4ca719a911a4641c8d94e43ff3a5c04e32 |

Original RAR hashes match GitHub's asset digests:

- v0.1.0: b837bb77eedbb46866f1e4603a8ee4f33afa334f3553e498a39aaf01b30b931a
- 0.1.2: db83a9d0b2e0bc27b1056c1d3f02fdde1452195c1a33c9ac9c4b0b40a681dc03

## Important v0.1.0 mismatch

The auto-generated Git-tag ZIP/tar.gz contains Artnspector.exe with SHA-256
97510d9cbfa168996814195766ce24dc01dac6132020b45863a7c7931b2909c4 and ten HLSL
files. The manually uploaded RAR contains TexelDensityInspector.exe and five
HLSL files. They are distinct builds. Their resources must remain paired with
their own executable. The 0.1.2 tag EXE does match the original 0.1.2 RAR EXE.

Both automatic Source code ZIP and tar.gz were downloaded; their file lists
agree for each tag and neither contains the later licensing bundle. These are
snapshots of a distribution repo, not the application's full C++ source.
Do not modify their historical tags merely to insert license files.

## Repack policy

Prepare additional, explicitly named `*-licensing-20260922.rar` assets from the
original RAR payload. Keep EVERY original file byte-for-byte, including the
executable name, resources, configuration and historical material README.
Add LICENSE.md, THIRD_PARTY_NOTICES.md, licenses/, public audit notes and a short
REPACK_NOTICE.md. Do not rebuild old EXEs or silently replace an original asset.
An old README may predate license links; the supplement does not rewrite it.

Candidate supplements retain unresolved historical dependency-version and
asset-provenance caveats. Adding files does not certify legal clearance.
Verify the extracted candidate, not only its staging directory, against the
original payload. Report EXECUTABLE UNCHANGED only after SHA-256 comparison.
Original archives, descriptions, tags and automatic Source code assets remain
unchanged until an explicitly reviewed publication step.

For v0.1.0, preserve the original executable filename rather than renaming it to
ArtInspector.exe. For current releases, ArtInspector.exe is the normal filename.
Never use the newer 0.1.2 materials to fill the older RAR's resource set.
