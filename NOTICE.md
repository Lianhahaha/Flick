# Third-party notices

Flick's own code is MIT. The demo also contains or depends on the following
MIT-licensed projects. Keep their notices when redistributing.

| Component | Upstream | License | Used for |
|---|---|---|---|
| ReelMimic | https://github.com/edenfunf/reelmimic | MIT | Anime-cel engine, template, character rigs, render contract |
| ClaudeAnimationBase / painted-animation | https://github.com/JohnHeibel/ClaudeAnimationBase · https://github.com/tuzhechen2005/painted-animation | MIT | Origin of `render.mjs` and the headless-Chrome render contract |
| Piper | https://github.com/rhasspy/piper | MIT | Local neural text-to-speech |
| Rhubarb Lip Sync | https://github.com/DanielSWolf/rhubarb-lip-sync | MIT | Audio → 2D mouth-shape cues |
| Toonflow | https://github.com/HBAI-Ltd/Toonflow-app | MIT | Reference architecture only; not vendored here |

The `en_US-lessac-medium` Piper voice model is **not** included in this repo.
Its model/dataset terms are separate from the Piper code license. Check the
model card before commercial use.

See [`third_party/`](third_party/) for the license texts we can redistribute.
