# ArtInspector

A standalone Windows tool for 3D asset inspection and artist self-checks before
assets move further through production. Author: [ArturPakkk](https://github.com/ArturPakkk).

## Current public version

The latest tagged release is **0.1.3**. This is the legacy ArtInspector distribution
repository: it contains executable builds, resources and licensing information,
not the complete C++ development project. The main-branch executable can differ
from an older tagged release; use each GitHub Release asset for a reproducible
published build. GitHub's “Source code” ZIP/tar.gz snapshots contain this
distribution repository, not the full application source. Private development
files are not needed to run it.

## Features

- FBX model import, a Direct3D 11 viewport and Outliner selection/visibility.
- UV0 and texel-density inspection, shading and face-orientation checks.
- Vertex-color, UV repetition and solid-wireframe checker materials.
- Collision-mesh display, Lit/Unlit modes, HDRI and directional lighting.
- Editable checker parameters, reset controls, Refresh and saved settings.

The package includes eleven HLSL materials. This is an inspection tool, not a UV
editor or a complete simulation of Unreal collision behavior. Bloom is not
implemented. Other formats supported internally by an importer are not promised
as application import formats.

## Installation

1. Open [Releases](https://github.com/ArturPakkk/ArtInspector_v_0.1.2/releases).
2. Download the Windows RAR for the intended version and extract the whole archive.
   Do not run the executable from inside the archive viewer.
3. Open the extracted ArtInspector folder and run ArtInspector.exe. Keep Config,
   Resources, LICENSE.md and licenses together with the executable.

Windows x64 with a Direct3D 11 / Shader Model 5.0 capable GPU is required by the
current build. Clean-machine minimum Windows support has not been certified.
Do not copy Windows system DLLs or fonts into the application folder yourself.

The original v0.1.0 and 0.1.2 RAR files predate the formal license bundle. Their
original assets remain preserved, and each legacy Release now also includes a
separate licensing-20260922 supplementary archive with the current licensing
documents. See [legacy release information](docs/licensing/LEGACY_RELEASES.md).
The original v0.1.0 RAR launches **TexelDensityInspector.exe**, whereas its Git-tag
snapshot contains **Artnspector.exe**; they are different historical builds.

## Repository structure

| Path | Purpose |
| --- | --- |
| ArtInspector.exe | Main-branch Windows executable |
| Config/ | Application configuration |
| Resources/Materials/ | Editable checkers and their usage guide |
| Resources/HDRI/ | Two bundled environment maps |
| licenses/ | Third-party notices and full license texts |
| docs/licensing/ | Public dependency, provenance and legacy release notes |
| OldVersions/ | Historical executables, not complete standalone packages |

OldVersions binaries are intentionally preserved, not reclassified as accidental
build junk. Prefer complete release assets for installation. No public build
instructions are supplied because the complete build inputs are not in this repo.

## Checker materials

See the [material guide](Resources/Materials/README.md). Keep edits/backups separate
when updating. Shader programs are compiled by the application; no SDK installation
is required merely to use the supplied checkers.

## Licensing and third-party software

ArtInspector's proprietary portion is governed by [LICENSE.md](LICENSE.md),
effective September 22, 2026. Personal and commercial use is allowed; general
redistribution, sale, rebranding and sublicensing rights are not granted.
Public visibility of these files does not make the application unrestricted
open-source software. Other explicit existing grants remain unaffected.

[Third-party notices](licenses/THIRD_PARTY_NOTICES.md) and component licenses apply
independently to their own code/fonts/assets. See the
[dependency audit](docs/licensing/DEPENDENCY_LICENSE_AUDIT.md) and
[provenance status](docs/licensing/ARTINSPECTOR_PROVENANCE.md).
Some provenance and legacy build-origin questions still require manual review.

## Legacy releases

Early tags predate the formal license notice. Their commits and tags are preserved;
the current terms do not purport to have existed inside those earlier commits.
[Legacy details and hashes](docs/licensing/LEGACY_RELEASES.md).
The software is provided as-is to the extent permitted by applicable law.
