"""Check relative Markdown links in the repo (stdlib only)."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
LINK = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
SKIP = ("http://", "https://", "mailto:", "#")


def main() -> int:
    bad: list[str] = []
    for md in sorted(ROOT.rglob("*.md")):
        if ".git" in md.parts:
            continue
        text = md.read_text(encoding="utf-8")
        for raw in LINK.findall(text):
            target = raw.strip().split("#", 1)[0].strip()
            if not target or target.startswith(SKIP):
                continue
            if target.startswith("<") and target.endswith(">"):
                target = target[1:-1]
            path = (md.parent / target).resolve()
            if not path.exists():
                bad.append(f"{md.relative_to(ROOT)} -> {raw}")

    if bad:
        print("Broken relative links:")
        for line in bad:
            print(f"  {line}")
        return 1
    print(f"Checked {len(list(ROOT.rglob('*.md')))} Markdown files: links OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
