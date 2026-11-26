"""Map Rhubarb Lip Sync mouth shapes to ReelMimic anime-cel mouth names."""

from __future__ import annotations

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


def map_rhubarb(value: str) -> str:
    """Return the anime-cel mouth for a Rhubarb shape; unknown values close."""
    return MAP.get(value, "n")
