# FAQ

## Is this a video model like Sora, Veo, or Runway?

No. Flick does not use a diffusion video model for the animation. ReelMimic's
engines draw every frame in code (Canvas/p5), then FFmpeg encodes the MP4. The
"AI" part is the agent that plans, writes the scene code, and reviews the
frames.

## Why not just prompt a video model?

Video models are good at photoreal or dreamlike shots, but they are weak at
reusable characters, exact timing, editable shots, and deterministic output.
Flick's approach gives you:

- a real project you can edit,
- the same character across shots,
- exact frame timing,
- no per-second video-model cost for every render.

The trade-off is that the look is stylized and limited by the drawing engine.

## Does it work on macOS or Linux?

The core pipeline is cross-platform, but `scripts/bootstrap.ps1` downloads
Windows binaries and the demo was built on Windows. On macOS/Linux, install
Piper and Rhubarb manually and put them on `PATH`, or adapt the bootstrap
script.

## Do I need Claude Code or Codex?

For the full ReelMimic app, upstream supports Claude Code and Codex. This repo
adds an **OpenCode** adapter so you can use OpenCode models such as DeepSeek
V4.1 Flash. See [`opencode-adapter.md`](opencode-adapter.md).

The voice demo and the rendered MP4 need no agent at all.

## Which DeepSeek model should I use?

The easiest way is the **API key** button in the ReelMimic composer: pick
OpenCode, click API key, and enter any OpenAI-compatible base URL + model.

If you use your own DeepSeek API key through OpenCode directly:

- `deepseek/deepseek-flash` — faster and cheaper; good for iteration.
- `deepseek/deepseek-v4-pro` — better at long code/planning turns; higher cost.

Set `OPENCODE_MODEL` in `~/.reelmimic/secrets.json` and restart ReelMimic. The
`OpenCode Go · max` label in the OpenCode UI means the OpenCode Go provider with
the max variant, not a model called "DeepSeek Max". See
[`opencode-adapter.md`](opencode-adapter.md).

If the direct model returns `Insufficient Balance`, the API key is configured
but the DeepSeek account has no credit. Top up or use `opencode-go/...`.

## Why is the repo only ~5.6 MB?

Because it contains source, docs, and the demo — not the 1 GB of upstream clones,
binaries, models, `node_modules`, and render frames. Those are downloaded by
`scripts/bootstrap.ps1`. This keeps clones fast and avoids committing other
projects' binaries.

## Can I use this commercially?

Flick's code is MIT. Third-party components are MIT as well, but check:

- the Piper voice model's terms,
- fonts and music,
- the reference video/style rights,
- the model provider's terms.

See [`licensing.md`](licensing.md).

## Why does ReelMimic take hours?

ReelMimic runs multiple agents, renders frames in headless Chrome, and reviews
each shot. A 30–60 s film can take 1–3.5 hours. The voice/lip-sync step itself is
fast; the animation review loop is the slow part.

## Can it make a 10-minute episode?

Not automatically. The current demo is 10.1 s; ReelMimic targets 30–60 s. Longer
episodes need more shots, more review, and human cleanup.

## Why does the demo cut to a close-up?

At a full-body wide shot the mouth is only a few pixels. The close-up makes the
lip-sync readable. A real 2D production would shoot it the same way.

## Why is ReelMimic patched instead of forked?

The patch is small, reviewable, and lives in [`../patches`](../patches). It is
based on a specific upstream commit. If upstream adds OpenCode support, the
patch can be dropped.

## Does it collect data?

The app runs locally. Agent prompts and project files go to the model provider
you configure (Claude, Codex, or OpenCode). ReelMimic sets telemetry-off
environment variables for HyperFrames/Remotion, but review the provider's terms.

## How do I contribute?

See [`../CONTRIBUTING.md`](../CONTRIBUTING.md). Small, tested changes are best.
