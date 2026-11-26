# Security policy

## Supported versions

Flick is a prototype. Security fixes are applied to `main` only.

## Reporting a vulnerability

Please do **not** open a public issue for a vulnerability.

Use GitHub's private security advisory flow:

<https://github.com/Lianhahaha/Flick/security/advisories/new>

Include:

- what you found,
- how to reproduce it,
- which version/commit you tested,
- any suggested fix.

This is a volunteer project; response times are best effort.

## Scope

Relevant areas:

- the local ReelMimic server and file API,
- the OpenCode/Claude Code/Codex adapters,
- prompt-injection paths through reference videos, transcripts, subtitles, and
  generated assets,
- secret handling (`~/.reelmimic/secrets.json`),
- dependency and model supply-chain issues.

## Important context

- ReelMimic runs agents with file-edit and shell access. Treat generated
  projects and reference files as untrusted input.
- The OpenCode adapter uses `--auto`, which auto-approves tool calls. ReelMimic's
  app-level gates still apply, but Claude Code's harness hooks do not run under
  OpenCode.
- The default setup binds the server to localhost. Do not expose port 4318 to
  the public internet without authentication and a reverse proxy.
- API keys belong in `~/.reelmimic/secrets.json`, never in the repo. The repo's
  `.gitignore` excludes it, but no ignore rule is a substitute for care.
