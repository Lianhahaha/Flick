# Comparison: why ReelMimic?

Flick is not trying to be a universal video model. It is a 2D animation agent
prototype. These are the projects we evaluated and the role each one plays.

| Project | Output | License | Role in this repo |
|---|---|---|---|
| [ReelMimic](https://github.com/edenfunf/reelmimic) | Code-drawn 2D frames, 7 engines, review pipeline | MIT | **Base for the animation demo** |
| [Toonflow](https://github.com/HBAI-Ltd/Toonflow-app) | AI short drama / motion comic, image + video models | MIT | Reference for script → storyboard → blocking |
| [HyperFrames](https://github.com/heygen-com/hyperframes) | HTML/CSS/JS motion graphics, deterministic MP4 | Apache-2.0 | Reference for a web-native renderer |
| [OpenMotion](https://github.com/nexu-io/openmotion) | Agentic motion-graphics studio, editable timeline | Apache-2.0 | Reference for product/editor architecture |
| [Piper](https://github.com/rhasspy/piper) | Local TTS | MIT | Voice generation |
| [Rhubarb Lip Sync](https://github.com/DanielSWolf/rhubarb-lip-sync) | Audio → mouth cues | MIT | Lip-sync |

## Why ReelMimic for the animation layer

- It produces **actual 2D animation frames**, not AI-generated video.
- It has rigged characters that can **walk, run, gesture, and talk**.
- It has a **review loop**: fresh reviewers, before/after evidence, round limits.
- It is MIT and small enough to understand.

## Why not Toonflow for this demo

Toonflow is excellent for script-to-short-drama, but its output is AI-generated
video/motion comic. It does not give you a deterministic 2D rig you can edit
frame by frame. It is a better fit for a different product shape.

## Why not HyperFrames or OpenMotion

Both are strong motion-graphics systems, but neither has a character rig,
walk cycle, or script-to-performance pipeline. They are good renderers/editors,
not a 2D character animation agent.

## Why not a video model

A video model can make a beautiful shot, but it is difficult to:

- keep the same character across shots,
- change one line without regenerating the film,
- guarantee frame-accurate timing,
- keep the output editable.

Flick uses a video model only as an optional future layer for complex shots —
not as the foundation.

## Caveats

This is not a benchmark. Licenses, features, and quality change quickly. Check
each upstream project before choosing it for a client.
