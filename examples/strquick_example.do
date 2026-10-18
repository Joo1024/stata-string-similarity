version 16.0
set more off

* Run from the repository root: do examples/strquick_example.do
* Load the local copy, even if another version is installed.
quietly run strquick.ado

strquick "same" "same"
assert abs(r(similarity) - 1) < 1e-12

strquick "abc" "xyz"
assert abs(r(similarity)) < 1e-12

strquick "different" "difficult"
assert abs(r(similarity) - 5/9) < 1e-12

strquick "北京人民大学" "南京大学"
assert abs(r(similarity) - 0.6) < 1e-12

* quick_ratio is an upper bound, not an exact-equality test.
strquick "ab" "ba"
assert abs(r(similarity) - 1) < 1e-12

strquick "" ""
assert abs(r(similarity) - 1) < 1e-12

* A later call must replace the previous result.
strquick "hello world" "hello world"
assert abs(r(similarity) - 1) < 1e-12
strquick "a" "b"
assert abs(r(similarity)) < 1e-12

* Embedded double quotes: use Stata compound double quotes. Expected: 1.
strquick `"say "hello""' `"say "hello""'
display r(similarity)

* Backslashes are passed as text to Python. Expected: 1.
strquick "C:\new\tools" "C:\new\tools"
display r(similarity)

display as result "Examples finished."
