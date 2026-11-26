# Contributing to Flick

Thanks for helping. This repo is a prototype, so the most useful contributions
are small, tested improvements — not giant rewrites.

## What this repo is

Flick is a working demo of a 2D animation agent:

- Piper TTS → local voice
- Rhubarb Lip Sync → mouth cues
- ReelMimic anime-cel → 2D frames
- FFmpeg → MP4

The upstream ReelMimic app and the voice tools are fetched by
`scripts/bootstrap.ps1`; they are not vendored here.

## Setup

```powershell
git clone https://github.com/Lianhahaha/Flick.git
cd Flick
powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1 -WithOpenCode
cd reelmimic
install.bat
```

Then:

```powershell
cd ..
start.bat
```

Open <http://localhost:4318>.

## Run the checks

```powershell
powershell -ExecutionPolicy Bypass -File scripts/check.ps1
```

Or manually:

```powershell
python -m py_compile voice/mouth_map.py voice/tts_lipsync.py voice/demo/build_demo.py voice/anime-demo/make_mouth.py
python -m pytest -q
cd voice/anime-demo
npm ci
node --check render.mjs
```

CI runs the same checks on Linux and Windows.

## Commit style

Use small, focused commits with Conventional Commit prefixes:

```text
feat(voice): add Tagalog phonetic mode
fix(demo): keep the mouth closed between lines
docs: explain why upstream binaries are not vendored
chore(ci): add Python 3.12 check
```

Do not combine unrelated changes. A visual change should include a screenshot
or a short clip in the PR.

## Pull requests

1. Open an issue first for anything larger than a typo.
2. Branch from `main`.
3. Keep the change focused.
4. Run `scripts/check.ps1`.
5. Describe what changed, why, and how you tested it.
6. For animation changes, include a before/after still or clip.

## Code guidelines

- TypeScript in the ReelMimic patch is strict; run `npm run typecheck` if you
  change it.
- Python scripts should stay dependency-light (stdlib unless there is a strong
  reason).
- Browser demos must work from a plain `file://` open (no local server needed).
- Do not commit:
  - `node_modules`, `voice/bin`, `voice/models`, `voice/downloads`
  - `out/frames`, render caches
  - API keys, secrets, personal paths
  - upstream repo clones
- Keep third-party notices in `NOTICE.md` and `third_party/`.

## AI-assisted contributions

AI-assisted code is welcome. Please:

- run the checks yourself;
- disclose that the change was AI-assisted in the PR;
- do not paste unreviewed generated code or large generated assets.

## Licensing

By contributing, you agree your contribution is licensed under the repo's MIT
license. Do not add code or assets you do not have the right to redistribute.

## Security

Do not open a public issue for a vulnerability. See [SECURITY.md](SECURITY.md).
