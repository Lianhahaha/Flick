# Anime-cel talking demo

A runnable ReelMimic anime-cel project. Hina walks in, stops, and speaks with a
Piper voice and a Rhubarb lip-sync track.

## Render

```powershell
npm install
node render.mjs --frames --workers=4
node render.mjs --encode --out=out/video.mp4 --audio=assets/voice.wav
```

Output: `out/video.mp4` — 1920×1080, 24 fps, ~9.3 s, H.264 + AAC.

For a quick preview sheet:

```powershell
node render.mjs --sheet=0.5,1.5,2.5,3.5,4.5,5.5,6.5,8.2 --cols=4 --w=480 --out=out/check/sheet.jpg
```

## How the mouth works

`src/mouth.js` is generated from `../assets/hina.json` by `make_mouth.py`:

```powershell
python make_mouth.py
```

It maps Rhubarb's A–H shapes to anime-cel mouth names:

| Rhubarb | Anime-cel |
|---|---|
| X, A | `n` |
| B, D, H | `a` |
| C | `e` |
| E | `o` |
| F | `u` |
| G | `i` |

`src/scenes/voice.js` calls:

```js
mouth: window.mouthAt(ta)
```

instead of the engine's random `talk()` flap. The absolute audio time is used in
the close-up shot so the mouth stays in sync across the cut.

## Credits

- Anime-cel engine and characters: [ReelMimic](https://github.com/edenfunf/reelmimic) (MIT)
- `render.mjs` contract: ClaudeAnimationBase / painted-animation (MIT)
- Voice: Piper (MIT)
- Lip-sync: Rhubarb Lip Sync (MIT)

See [`../../NOTICE.md`](../../NOTICE.md).
