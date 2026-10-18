*! strquick 0.1.0 18oct2026
cap program drop strquick
program define strquick, rclass
    version 16.0
    args first second
    tempname result
    python: _strquick_score()
    return scalar similarity = scalar(`result')
end

python:
from sfi import Macro, Scalar
from difflib import SequenceMatcher


def _strquick_score():
    first = Macro.getLocal("first")
    second = Macro.getLocal("second")
    score = SequenceMatcher(None, first, second).quick_ratio()
    Scalar.setValue(Macro.getLocal("result"), score)
end
