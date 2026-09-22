# License files for ArtInspector v0.1.2

This directory is copied in full beside ArtInspector.exe by build.bat through
tools/Deploy.ps1. Keep it with the application and keep LICENSE.md at its root.
The old root THIRD_PARTY_NOTICES.md now points to this canonical index.

- native/Dear-ImGui-MIT.txt: vendored ImGui and Win32/DX11 backends.
- native/ufbx-LICENSE.txt: complete vendored dual license; MIT alternative used.
- native/imstb_*-LICENSE.txt: full license blocks extracted from the three
  ImGui-modified stb headers; MIT alternative used.
- native/DirectXMath-MIT.txt: Microsoft SDK inline math/collision code.
- fonts/ProggyClean-MIT.txt and fonts/ProggyForever-MIT.txt: embedded ImGui fonts.
- assets/PolyHaven.txt and assets/CC0-1.0.txt: two identified HDRI files.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for upstream sources,
copyrights, use and unresolved provenance. License copying is not certification
that every provenance question has been settled. The audit is in
../docs/licensing/DEPENDENCY_LICENSE_AUDIT.md in the source tree.
No npm, Diligent, Electron or React runtime is distributed by this build.
