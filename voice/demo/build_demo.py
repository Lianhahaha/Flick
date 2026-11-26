"""Inject Rhubarb cues into template.html and write a standalone demo page."""

from __future__ import annotations

import base64
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
VOICE = HERE.parent


def main() -> None:
    cues = json.loads((VOICE / "assets" / "hina.json").read_text(encoding="utf-8"))["mouthCues"]
    wav = (VOICE / "assets" / "hina.wav").read_bytes()
    data_uri = "data:audio/wav;base64," + base64.b64encode(wav).decode("ascii")
    template = (HERE / "template.html").read_text(encoding="utf-8")
    html = template.replace("__CUES__", json.dumps(cues, separators=(",", ":")))
    html = html.replace('src="hina.wav"', f'src="{data_uri}"')
    (HERE / "index.html").write_text(html, encoding="utf-8")
    print(f"Wrote {HERE / 'index.html'} ({len(html):,} bytes, audio embedded)")


if __name__ == "__main__":
    main()
