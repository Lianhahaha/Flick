"""Convert Rhubarb mouth cues (A-H) to ReelMimic anime-cel mouth names."""

from __future__ import annotations

import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
CUES = HERE.parent / "assets" / "hina.json"

# Rhubarb A-H -> anime-cel mouth names (a i u e o n + expression mouths).
MAP = {
    "X": "n",
    "A": "n",
    "B": "a",
    "C": "e",
    "D": "a",
    "E": "o",
    "F": "u",
    "G": "i",
    "H": "a",
}


def main() -> None:
    data = json.loads(CUES.read_text(encoding="utf-8"))
    cues = []
    for c in data["mouthCues"]:
        cues.append([round(c["start"], 3), round(c["end"], 3), MAP.get(c["value"], "n")])
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
