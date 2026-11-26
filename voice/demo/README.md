# Hina voice demo

Open `index.html` and press **Play voice**.

The audio is embedded as a data URI; no server or network is required. The page
shows the current Rhubarb mouth shape while the character speaks.

## Rebuild

After changing `../assets/hina.wav` or `../assets/hina.json`:

```powershell
python build_demo.py
```

That injects the cues into `template.html` and writes `index.html`.

## Link

The page links to `../../demo/hina-walking-talking.mp4`, the full anime-cel clip.
