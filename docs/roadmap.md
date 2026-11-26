# Roadmap

## Done

- [x] Local Piper TTS → WAV
- [x] Rhubarb Lip Sync → mouth cues
- [x] Rhubarb A–H → ReelMimic `a/i/u/e/o/n`
- [x] Anime-cel walking shot
- [x] Anime-cel medium close-up talking shot
- [x] 9.3 s MP4 with H.264 video + AAC audio
- [x] Standalone browser demo with embedded audio
- [x] Windows launchers
- [x] Bootstrap script for upstream clones and voice tools
- [x] OpenCode director adapter (DeepSeek V4.1 Flash)
- [x] Public repo docs, CI, templates, and checks

## Next: one 30–60 second dialogue scene

- [ ] Add a screenplay schema: scenes, beats, dialogue lines, character IDs,
      emotions, voice IDs
- [ ] Generate one TTS WAV per line
- [ ] Merge per-line Rhubarb cues into one mouth timeline
- [ ] Add a second character and a conversation
- [ ] Add shot-level voice/character consistency checks
- [ ] Integrate the voice track into ReelMimic's plan → production flow

**Acceptance:** 30–60 s, two characters, 6–10 shots, dialogue, captions, voice,
and lip-sync, rendered from one script.

## Then: production quality

- [ ] Replace Piper with a higher-quality TTS option (Chatterbox, F5-TTS, or
      a licensed API) while keeping Piper as the offline fallback
- [ ] Add a Filipino/Tagalog voice and test Rhubarb `--phonetic`
- [ ] Add a simple timeline/shot editor: preview, regenerate one shot, replace
      a voice line
- [ ] Add character voice casting and per-character mouth styles
- [ ] Add a proper review rubric: lip-sync, character consistency, motion,
      story clarity, captions

## Later: product layer

- [ ] Server-side agent instead of a local Claude Code/Codex CLI
- [ ] Project storage, queue, worker pool, render farm
- [ ] Auth, billing, usage caps
- [ ] Asset library: characters, rigs, backgrounds, voices, motion presets
- [ ] Export: MP4 + editable project
- [ ] Compare against Toonflow for script-to-video workflows

## Risks

- **Character consistency** across shots is the hardest part. Rigs help; pure
  image/video generation drifts.
- **Lip-sync** is only as good as the voice timing and the mouth set. More mouth
  shapes and a viseme map would improve it.
- **Cost/time**: ReelMimic's full production is heavy; a 30–60 s film can take
  1–3.5 hours. The voice pipeline itself is fast.
- **Licensing**: voice models, music, fonts, and reference styles each have
  their own terms. See [licensing.md](licensing.md).
- **Scope**: "everything a 2D animation could have" is unbounded. Ship one
  concrete format first: 30–60 s, two characters, simple sets.
