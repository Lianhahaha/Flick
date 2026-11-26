"""Convert Rhubarb mouth cues (A-H) to ReelMimic anime-cel mouth names."""

from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
CUES = HERE.parent / "assets" / "hina.json"
sys.path.insert(0, str(HERE.parent))
from mouth_map import map_rhubarb  # noqa: E402  (path set above)


def main() -> None:
    data = json.loads(CUES.read_text(encoding="utf-8"))
    cues = []
    for c in data["mouthCues"]:
        cues.append([round(c["start"], 3), round(c["end"], 3), map_rhubarb(c["value"])])
    body = json.dumps(cues, separators=(",", ":"))
    js = f"""// Generated from hina.json by make_mouth.py — Rhubarb A-H mapped to anime-cel mouths.
window.MOUTH_CUES = {body};
window.mouthAt = function (t) {{
  const c = window.MOUTH_CUES;
  for (let i = 0; i < c.length; i++) if (t >= c[i][0] && t < c[i][1]) return c[i][2];
  return 'n';
}};
"""
    (HERE / "src" / "mouth.js").write_text(js, encoding="utf-8")
    print(f"Wrote {HERE / 'src' / 'mouth.js'} ({len(cues)} cues)")


if __name__ == "__main__":
    main()
