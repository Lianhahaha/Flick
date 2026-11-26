# Licensing and client-work notes

## This repo

Flick's own code is MIT. You can use it commercially, modify it, and redistribute
it, provided you keep the copyright notice.

## Third-party code and assets

| Component | License | Notes |
|---|---|---|
| ReelMimic anime-cel engine/template | MIT | Keep the ReelMimic notice |
| `render.mjs` (ClaudeAnimationBase / painted-animation) | MIT | Keep `LICENSE-render.mjs.txt` |
| Piper | MIT | Keep the Piper license |
| Rhubarb Lip Sync | MIT | Keep the Rhubarb license |
| Toonflow | MIT | Reference only; not vendored here |

License texts are in [`third_party/`](../third_party/).

## Voice models

The Piper **code** is MIT. The **voice model** has its own terms. The included
`en_US-lessac-medium` model is not committed to this repo; `scripts/bootstrap.ps1`
downloads it. Check the model card before commercial use.

For client work, use a voice you have rights to:

- a licensed API voice (ElevenLabs, Azure, Google)
- a voice model with a commercial-use license
- the client's own recorded voice

## Reference videos and style

- Use a reference video to study pacing, framing, transitions, and camera moves.
- Do not reuse its footage, characters, logos, or music.
- Do not promise an exact copy of a living artist's signature style.
- Get the client's written approval for the style direction.

## Music, fonts, and stock assets

- Music must be supplied by the client or licensed.
- Fonts need a web/embedding license for commercial output.
- Stock images/SFX need a license record. ReelMimic's asset fetcher writes
  `ASSETS.md` for this reason.

## Client checklist

- [ ] Who owns the generated video and project files?
- [ ] Which voice model/service is allowed?
- [ ] Which reference video/style is allowed?
- [ ] Which music/fonts/assets are licensed?
- [ ] Is the output for social, broadcast, or internal use?
- [ ] Does the client need indemnification? If so, use licensed APIs/models
      with clear commercial terms, not research-only weights.
