# Flick - local checks (no Chrome, no models, no network).
# Run from anywhere: powershell -ExecutionPolicy Bypass -File scripts/check.ps1
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

$failed = 0
function Step([string]$Name, [scriptblock]$Body) {
  Write-Host "`n== $Name" -ForegroundColor Cyan
  $global:LASTEXITCODE = 0
  try {
    & $Body
    if ($LASTEXITCODE -ne 0) { throw "command failed (exit $LASTEXITCODE)" }
  } catch {
    Write-Host "  FAIL: $($_.Exception.Message)" -ForegroundColor Red
    $script:failed++
  }
}

Step "Required files" {
  $required = @(
    "README.md", "LICENSE", "NOTICE.md",
    "voice/tts_lipsync.py", "voice/mouth_map.py",
    "voice/demo/index.html", "voice/anime-demo/src/scenes/voice.js",
    "demo/hina-walking-talking.mp4"
  )
  foreach ($f in $required) {
    if (-not (Test-Path $f)) { throw "missing: $f" }
    Write-Host "  ok: $f"
  }
}

Step "Python syntax" {
  python -m py_compile voice/mouth_map.py voice/tts_lipsync.py voice/demo/build_demo.py voice/anime-demo/make_mouth.py
  Write-Host "  ok"
}

Step "Python tests" {
  python -m pytest --version 2>$null | Out-Null
  if ($LASTEXITCODE -ne 0) {
    Write-Host "  skip: pytest not installed (pip install -r requirements-dev.txt)"
    $global:LASTEXITCODE = 0
    return
  }
  python -m pytest -q
}

Step "JavaScript syntax" {
  node --check voice/anime-demo/render.mjs
  if ($LASTEXITCODE -ne 0) { throw "render.mjs failed" }
  Get-ChildItem voice/anime-demo/src -Recurse -Filter *.js | ForEach-Object {
    node --check $_.FullName
    if ($LASTEXITCODE -ne 0) { throw "$($_.Name) failed" }
  }
  Write-Host "  ok"
}

Step "JSON files" {
  $json = @("voice/assets/hina.json", "voice/anime-demo/package.json", "voice/anime-demo/package-lock.json")
  python -c "import json,sys; [json.load(open(p, encoding='utf-8')) for p in sys.argv[1:]]" @json
  foreach ($f in $json) { Write-Host "  ok: $f" }
}

Step "Markdown links" {
  python scripts/check_links.py
}

Step "PowerShell syntax" {
  $errors = $null
  [System.Management.Automation.Language.Parser]::ParseFile((Join-Path $Root "scripts/bootstrap.ps1"), [ref]$null, [ref]$errors) | Out-Null
  if ($errors) { throw ($errors | Select-Object -First 1).Message }
  Write-Host "  ok: scripts/bootstrap.ps1"
}

if ($failed -gt 0) {
  Write-Host "`n$failed check(s) failed." -ForegroundColor Red
  exit 1
}
Write-Host "`nAll checks passed." -ForegroundColor Green
