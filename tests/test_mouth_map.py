from voice.mouth_map import MAP, map_rhubarb


def test_known_shapes() -> None:
    assert map_rhubarb("X") == "n"
    assert map_rhubarb("A") == "n"
    assert map_rhubarb("B") == "a"
    assert map_rhubarb("C") == "e"
    assert map_rhubarb("D") == "a"
    assert map_rhubarb("E") == "o"
    assert map_rhubarb("F") == "u"
    assert map_rhubarb("G") == "i"
    assert map_rhubarb("H") == "a"


def test_unknown_shape_closes() -> None:
    assert map_rhubarb("?") == "n"
    assert map_rhubarb("") == "n"


def test_map_is_complete() -> None:
    assert set(MAP) == set("XABCDEFGH")
