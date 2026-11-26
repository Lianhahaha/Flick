# Setup

## Prerequisites

- Windows 10/11 (the demo was built on Windows)
- Git
- Node.js 22.18+ (26.x works; CI upstream tests 22.18/24)
- Python 3.10+
- FFmpeg + ffprobe on PATH
- Google Chrome
- Claude Code or Codex CLI for the full ReelMimic app

## 1. Bootstrap

From the repo root:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1
```

This will:

- clone `reelmimic` (and `toonflow` if you pass `-WithToonflow`)
- download Piper and Rhubarb Windows binaries
- download the `en_US-lessac-medium` voice model

It does **not** install ReelMimic's Python/npm dependencies.

## 2. Install ReelMimic

```powershell
cd reelmimic
install.bat
```

Or manually:

```powershell
python -m pip install -r requirements.txt
cd app
npm install
npm run build
node scripts/doctor.mjs
```

Start it:

```powershell
cd ..
start.bat
```

Open <http://localhost:4318>.

## 3. Run the standalone voice demo

Open `voice/demo/index.html` in Chrome and press **Play voice**.

The audio is embedded as a data URI, so no server is needed.

## 4. Render the anime-cel clip

```powershell
cd voice/anime-demo
npm install
node render.mjs --frames --workers=4
node render.mjs --encode --out=out/video.mp4 --audio=assets/voice.wav
```

Output: `voice/anime-demo/out/video.mp4`.

## 5. Generate a new voice line

```powershell
cd voice
python tts_lipsync.py "Your line here" --out demo/line1
```

Outputs:

- `demo/line1.wav`
- `demo/line1.json` (Rhubarb cues)

For Tagalog/Filipino:

```powershell
python tts_lipsync.py "Kumusta! Ako si Hina." --out demo/line1 --phonetic
```

The included Piper voice is English; use a Filipino TTS voice for natural
Tagalog pronunciation.

## 6. Rebuild the anime-cel mouth track

After replacing `voice/assets/hina.json` with a new Rhubarb JSON:

```powershell
cd voice/anime-demo
python make_mouth.py
```

Then re-render the frames.

## Troubleshooting

| Problem | Fix |
|---|---|
| `piper.exe` missing | Run `scripts/bootstrap.ps1` or download the Piper Windows zip manually |
| `rhubarb.exe` missing | Run `scripts/bootstrap.ps1` or download Rhubarb 1.14.0 Windows zip |
| Chrome not found | Set `CHROME_PATH` or install Chrome |
| `node render.mjs` can't find `puppeteer-core` | `cd voice/anime-demo && npm install` |
| ReelMimic doctor fails | Install the missing item it names; see upstream `TROUBLESHOOTING.md` |
| Port 4318 already used | Open <http://localhost:4318> — the server is already running |

## File sizes

The repo intentionally does **not** commit:

- ReelMimic, Toonflow, Piper, or Rhubarb source clones
- Piper/Rhubarb binaries
- voice models
- `node_modules`
- rendered frame caches

The committed demo MP4 is about 3.4 MB.
