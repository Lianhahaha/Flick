"""Generate a local voice line and a Rhubarb lip-sync track.

Usage:
  python tts_lipsync.py "Hello, I am a 2D character." --out demo/line1

Writes:
  demo/line1.wav
  demo/line1.json   (Rhubarb mouth cues: A-H)
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

BASE = Path(__file__).resolve().parent
PIPER = BASE / "bin" / "piper" / "piper" / "piper.exe"
RHUBARB = BASE / "bin" / "rhubarb" / "Rhubarb-Lip-Sync-1.14.0-Windows" / "rhubarb.exe"
MODEL = BASE / "models" / "en_US-lessac-medium.onnx"


def run(cmd: list[str], **kwargs) -> None:
    print("+", " ".join(str(x) for x in cmd))
    subprocess.run(cmd, check=True, **kwargs)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("text", help="Line to speak")
    ap.add_argument("--out", default="demo/line1", help="Output basename (without extension)")
    ap.add_argument("--voice", default=str(MODEL), help="Piper .onnx voice model")
    ap.add_argument("--phonetic", action="store_true", help="Language-independent recognizer (use for Tagalog / non-English)")
    args = ap.parse_args()

    out = Path(args.out)
    if not out.is_absolute():
        out = BASE / out
    out.parent.mkdir(parents=True, exist_ok=True)
    wav = out.with_suffix(".wav")
    js = out.with_suffix(".json")

    for path in (PIPER, RHUBARB, Path(args.voice)):
        if not path.exists():
            print(f"Missing: {path}", file=sys.stderr)
            return 1

    run([str(PIPER), "--model", str(args.voice), "--output_file", str(wav)], input=args.text.encode("utf-8"))
    run([str(RHUBARB), "-r", "phonetic" if args.phonetic else "pocketSphinx", "-f", "json", "-o", str(js), str(wav)])
    print(f"\nWrote:\n  {wav}\n  {js}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
