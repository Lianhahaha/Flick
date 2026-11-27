# Changelog

All notable changes to Flick are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project uses
[Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-11-26

### Added

- Contributor guide, code of conduct, security policy, and changelog
- GitHub issue/PR templates, Dependabot, and CI
- EditorConfig and additional ignore rules
- FAQ, project comparison, and demo README
- Relative Markdown link checker
- Citation metadata
- README logo, badges, requirements, and documentation map
- macOS/Linux setup notes
- ReelMimic OpenCode screenshot
- OpenCode director adapter patch for ReelMimic
- `OPENCODE_MODEL`, `OPENCODE_AGENT`, and `OPENCODE_BIN` configuration
- OpenCode option in the ReelMimic composer and header
- Bootstrap `-WithOpenCode` flag
- Architecture, setup, licensing, roadmap, and OpenCode adapter docs

### Changed

- GitHub Actions updated to v7
- Quickstart renamed and updated for OpenCode/bootstrap
- Removed a duplicate demo audio file
- Roadmap updated with OpenCode and public-polish status
- Anime demo has `npm run render` and `npm run sheet`

### Fixed

- Render the full 10.1 s voice track instead of cutting the last 0.8 s
- Keep the final subtitle visible through the last line
- Remove an absolute local path from the Rhubarb metadata
- Local check script now fails when a command fails
- Link checker skips vendored/ignored directories
- Documented why upstream binaries/models are not vendored
- Added a collaborator setup path

## [0.1.0] - 2026-11-26

### Added

- Piper TTS + Rhubarb Lip Sync pipeline
- Rhubarb A–H → ReelMimic mouth mapping
- 9.3 s Hina walking/talking anime-cel clip
- Standalone browser voice demo with embedded audio
- Windows launchers
- MIT license and third-party notices
