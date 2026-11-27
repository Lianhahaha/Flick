# Changelog

All notable changes to Flick are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project uses
[Semantic Versioning](https://semver.org/).

## [0.3.3] - 2026-11-27

### Fixed

- New projects default to fast instead of fine: fine-by-default made a 7 s film spend hours in the cast gate
- Agent turns are capped at 45 minutes (`AGENT_TIMEOUT_MS`)
- The character gate is capped at 45 minutes (`CAST_BUDGET_MS`)
- Cast review is limited to the character sheet, key poses, and eight crops per character instead of the whole film
- Short films (≤15 s) only generate the expressions/poses the plan uses

## [0.3.2] - 2026-11-27

### Fixed

- Custom API panel closes when switching agents or opening quality/rounds
- API key panel validates the key and URL locally before sending
- Composer controls wrap on mobile; the agent picker gets its own row
- `/help` hint appears in the OpenCode chat placeholder
- Slash-command replies follow the project language

## [0.3.1] - 2026-11-27

### Added

- `/help`, `/status`, `/model`, and `/key` commands in project chat

## [0.3.0] - 2026-11-27

### Added

- API key button for any OpenAI-compatible endpoint
- Custom provider config generated in `.opencode/opencode.json`
- Server-side API key storage in `~/.reelmimic/secrets.json` (never in a project)
- Direct DeepSeek model documentation and balance-error guidance

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
