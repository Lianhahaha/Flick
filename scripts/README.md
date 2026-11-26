# Scripts

## `bootstrap.ps1`

Fetches the upstream repos and local voice tools.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1
```

Options:

| Flag | Effect |
|---|---|
| `-WithToonflow` | Also clone Toonflow (reference only) |
| `-WithOpenCode` | Apply the OpenCode director patch to ReelMimic |
| `-SkipReelMimic` | Do not clone ReelMimic |

What it downloads:

- ReelMimic (git clone, depth 1)
- Piper Windows binary 2023.11.14-2
- Rhubarb Lip Sync 1.14.0 Windows binary
- `en_US-lessac-medium` Piper voice model

It does **not** run `pip install` or `npm install`. Those are separate steps so
you can see what is being installed.
