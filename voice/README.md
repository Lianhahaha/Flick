# Voice pipeline

Piper TTS → WAV → Rhubarb Lip Sync → mouth cues → ReelMimic mouth names.

## Generate a voice line + mouth track

```powershell
python tts_lipsync.py "Your line here" --out demo/line1
```

Outputs:

- `demo/line1.wav`
- `demo/line1.json` — Rhubarb `mouthCues`

For Tagalog/Filipino:

```powershell
python tts_lipsync.py "Kumusta! Ako si Hina." --out demo/line1 --phonetic
```

`--phonetic` uses Rhubarb's language-independent recognizer. It is less precise
than the English recognizer, but it works for other languages.

## Files

| Path | Purpose |
|---|---|
| `tts_lipsync.py` | Wraps Piper + Rhubarb |
| `assets/hina.wav` | The demo voice line |
| `assets/hina.json` | Rhubarb cues for that line |
| `demo/` | Standalone browser demo |
| `anime-demo/` | ReelMimic anime-cel project that uses the mouth track |

## Rebuild the browser demo

```powershell
python demo/build_demo.py
```

This injects the cues into `demo/template.html`, embeds the WAV, and writes
`demo/index.html`.

## Rebuild the anime-cel mouth track

```powershell
cd anime-demo
python make_mouth.py
```

This reads `../assets/hina.json` and writes `src/mouth.js`.

## License note

Piper and Rhubarb are MIT. The voice model has its own terms; see
[../docs/licensing.md](../docs/licensing.md).
