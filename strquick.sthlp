{smcl}
{* *! version 0.1.0 18oct2026}{...}
{title:Title}

{p 4 4 2}
{cmd:strquick} {hline 2} Quick character similarity for two literal strings

{title:Syntax}

{p 8 8 2}
{cmd:strquick} {it:"string1"} {it:"string2"}

{title:Description}

{pstd}
{cmd:strquick} uses Python's {cmd:difflib.SequenceMatcher.quick_ratio()} and
returns a score between 0 and 1 in {cmd:r(similarity)}. It requires Stata 16
or later and a compatible, configured Python installation. No third-party
Python packages or Anaconda installation are required.

{pstd}
The score is a quick upper bound on {cmd:SequenceMatcher.ratio()}, not
edit distance or semantic similarity. Reordered characters may produce 1:
{cmd:strquick "ab" "ba"} returns 1 although the strings differ. Two empty
strings return 1. Comparison is case-sensitive and includes whitespace
and punctuation; there is no normalization.

{title:Python setup}

{phang2}{cmd:. python query}

{pstd}
If necessary, replace the example path with a compatible Python executable:

{phang2}{cmd:. python set exec "/absolute/path/to/python3", permanently}

{title:Examples}

{phang2}{cmd:. strquick "different" "difficult"}
{phang2}{cmd:. display r(similarity)}
{p 12 12 2}Returns approximately 0.55555556.

{phang2}{cmd:. strquick "北京人民大学" "南京大学"}
{phang2}{cmd:. display r(similarity)}
{p 12 12 2}Returns 0.6.

{phang2}{cmd:. strquick "same" "same"}
{phang2}{cmd:. display r(similarity)}
{p 12 12 2}Returns 1.

{title:Stored results}

{pstd}
{cmd:strquick} stores the following in {cmd:r()}:

{synoptset 18 tabbed}{...}
{synopt:{cmd:r(similarity)}}Quick similarity score in [0, 1]{p_end}

{pstd}
Read this result before another r-class command replaces it.

{title:Limitations}

{pstd}
This command compares literal text, not variables observation by observation.
Quote strings containing spaces. For embedded double quotes, use Stata compound double quotes; see
{cmd:examples/strquick_example.do} in the repository.
Arguments are read using {cmd:sfi.Macro.getLocal()}, not inserted into
Python source code. Stata quoting and macro expansion rules still apply.
Do not interpret a score of 1 as proof of exact equality.

{title:Author and license}

{pstd}
Joo1024. MIT license; see LICENSE in the repository.

{title:References}

{pstd}
{browse "https://github.com/Joo1024/stata-string-similarity":Repository and installation instructions}

{pstd}
{browse "https://docs.python.org/3/library/difflib.html#difflib.SequenceMatcher.quick_ratio":Python quick_ratio documentation}

{pstd}
{browse "https://www.stata.com/python/":Stata Python integration}
