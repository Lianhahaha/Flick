# Patches

## `reelmimic-opencode-agent.patch`

Adds OpenCode (DeepSeek V4.1 Flash) as a third ReelMimic director.

Apply:

```powershell
cd reelmimic
git apply ../patches/reelmimic-opencode-agent.patch
cd app
npm run build
```

Or:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1 -WithOpenCode
```

See [`../docs/opencode-adapter.md`](../docs/opencode-adapter.md) for
configuration and caveats.

The patch was generated against ReelMimic commit `0c3bfa1`. If it no longer
applies cleanly, use:

```powershell
git apply -3 ../patches/reelmimic-opencode-agent.patch
```

and resolve any conflicts.
