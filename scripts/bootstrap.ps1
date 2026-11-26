<#
.SYNOPSIS
  Fetch the upstream 2D animation repos and the local voice tools.

.DESCRIPTION
  Clones ReelMimic (MIT) and, optionally, Toonflow (MIT). Downloads the Windows
  Piper + Rhubarb binaries and the English voice model used by the demo.

  This does not install ReelMimic's Python/npm dependencies. Do that with
  reelmimic\install.bat after this script finishes.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1 -WithToonflow

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts/bootstrap.ps1 -WithOpenCode
#>

param(
  [switch]$WithToonflow,
  [switch]$WithOpenCode,
  [switch]$SkipReelMimic
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

function Write-Step([string]$Text) {
  Write-Host "`n== $Text" -ForegroundColor Cyan
}

function Download([string]$Url, [string]$OutFile) {
  $dir = Split-Path -Parent $OutFile
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  if (Test-Path $OutFile) {
    Write-Host "  exists: $OutFile"
    return
  }
  Write-Host "  downloading: $Url"
  if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
    & curl.exe -L --retry 3 --silent --show-error -o $OutFile $Url
    if ($LASTEXITCODE -ne 0) { throw "curl failed: $Url" }
  } else {
    Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $OutFile
  }
}

function Expand-Zip([string]$Zip, [string]$Dest) {
  New-Item -ItemType Directory -Force -Path $Dest | Out-Null
  Expand-Archive -Force -Path $Zip -DestinationPath $Dest
}

Write-Step "Folders"
foreach ($d in @("voice\bin", "voice\models", "voice\downloads")) {
  New-Item -ItemType Directory -Force -Path (Join-Path $Root $d) | Out-Null
}

if (-not $SkipReelMimic) {
  Write-Step "ReelMimic"
  if (Test-Path (Join-Path $Root "reelmimic\.git")) {
    Write-Host "  exists: reelmimic"
  } else {
    & git clone --depth 1 https://github.com/edenfunf/reelmimic.git (Join-Path $Root "reelmimic")
    if ($LASTEXITCODE -ne 0) { throw "git clone reelmimic failed" }
  }
}

if ($WithOpenCode) {
  Write-Step "OpenCode director patch"
  $reel = Join-Path $Root "reelmimic"
  $patch = Join-Path $Root "patches\reelmimic-opencode-agent.patch"
  if (-not (Test-Path (Join-Path $reel ".git"))) {
    Write-Warning "reelmimic is not present; run without -SkipReelMimic first"
  } elseif (-not (Test-Path $patch)) {
    Write-Warning "patch not found: $patch"
  } elseif (Select-String -Path (Join-Path $reel "app\shared\types.ts") -Pattern "opencode" -Quiet) {
    Write-Host "  already applied"
  } else {
    & git -C $reel apply --check $patch
    if ($LASTEXITCODE -eq 0) {
      & git -C $reel apply $patch
      if ($LASTEXITCODE -ne 0) { throw "git apply failed" }
      Write-Host "  applied: $patch"
    } else {
      Write-Warning "patch does not apply cleanly; try: git -C reelmimic apply -3 ..\patches\reelmimic-opencode-agent.patch"
    }
  }
}

if ($WithToonflow) {
  Write-Step "Toonflow (reference)"
  if (Test-Path (Join-Path $Root "toonflow\.git")) {
    Write-Host "  exists: toonflow"
  } else {
    & git clone --depth 1 https://github.com/HBAI-Ltd/Toonflow-app.git (Join-Path $Root "toonflow")
    if ($LASTEXITCODE -ne 0) { throw "git clone toonflow failed" }
  }
}

Write-Step "Piper"
$piperZip = Join-Path $Root "voice\downloads\piper.zip"
Download "https://github.com/rhasspy/piper/releases/download/2023.11.14-2/piper_windows_amd64.zip" $piperZip
if (-not (Test-Path (Join-Path $Root "voice\bin\piper\piper\piper.exe"))) {
  Expand-Zip $piperZip (Join-Path $Root "voice\bin\piper")
}

Write-Step "Rhubarb Lip Sync"
$rhubarbZip = Join-Path $Root "voice\downloads\rhubarb.zip"
Download "https://github.com/DanielSWolf/rhubarb-lip-sync/releases/download/v1.14.0/Rhubarb-Lip-Sync-1.14.0-Windows.zip" $rhubarbZip
if (-not (Test-Path (Join-Path $Root "voice\bin\rhubarb\Rhubarb-Lip-Sync-1.14.0-Windows\rhubarb.exe"))) {
  Expand-Zip $rhubarbZip (Join-Path $Root "voice\bin\rhubarb")
}

Write-Step "Voice model (en_US-lessac-medium)"
$voiceBase = "https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/lessac/medium"
Download "$voiceBase/en_US-lessac-medium.onnx" (Join-Path $Root "voice\models\en_US-lessac-medium.onnx")
Download "$voiceBase/en_US-lessac-medium.onnx.json" (Join-Path $Root "voice\models\en_US-lessac-medium.onnx.json")

Write-Step "Done"
Write-Host @"
Next:
  1. Install ReelMimic:
       cd reelmimic
       install.bat
  2. Try the voice demo:
       voice\demo\index.html
  3. Render the anime clip:
       cd voice\anime-demo
       npm install
       node render.mjs --frames --workers=4
       node render.mjs --encode --out=out/video.mp4 --audio=assets/voice.wav
"@ -ForegroundColor Green
