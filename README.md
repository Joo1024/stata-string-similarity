# stata-string-similarity

Compare two strings in Stata with **`strquick`**, a small command powered by
Python's `difflib.SequenceMatcher.quick_ratio()`.

一个在 Stata 中比较两段文本的字符相似度的小工具，支持中文和英文。

```stata
strquick "different" "difficult"
display r(similarity)
// 0.55555556 (rounded)

strquick "北京人民大学" "南京大学"
display r(similarity)
// 0.6
```

## Requirements

- Stata 16 or later, with Python integration configured.
- A Python installation supported by your Stata version.
- No third-party Python packages are required; Anaconda is optional.

Check your Python configuration in Stata:

```stata
python query
```

If needed, select your Python executable using its actual path:

```stata
python set exec "/absolute/path/to/python3", permanently
```

See [Stata's Python integration documentation](https://www.stata.com/python/).

## Installation

### From a local copy

Download or clone this repository. In Stata, replace the path below with your
local repository directory:

```stata
net install strquick, from("/absolute/path/to/stata-string-similarity") replace
which strquick
help strquick
```

This installs the command and help file into Stata's user-written ado directory.

### From GitHub

This URL becomes available after the GitHub repository is renamed to
`stata-string-similarity`, made public, and these files are pushed to `main`:

```stata
net install strquick, from("https://raw.githubusercontent.com/Joo1024/stata-string-similarity/main/") replace
```

## Usage

```stata
strquick "first string" "second string"
display r(similarity)
```

- Each call compares one pair of literal strings, not two Stata variables.
- The result is stored in **`r(similarity)`**, between 0 and 1.
- Quote strings containing spaces. Use Stata compound double quotes for text
  containing double quotes, as shown below.
- Read or save the result before another r-class command replaces it.

```stata
strquick `"say "hello""' `"say "hello""'
display r(similarity)
// 1
```

Arguments are read from Stata local macros through `sfi.Macro.getLocal()`;
they are not inserted into Python source code. Stata's normal quoting and macro
expansion rules still apply before the text reaches Python.

## Understanding the score

The score estimates character overlap. Comparison is case-sensitive and includes
spaces and punctuation. No trimming, case conversion, or Unicode normalization
is performed.

**`quick_ratio()` is an upper bound on `SequenceMatcher.ratio()`.** It does not
measure meaning or edit distance, and it does not account for character order:

| First string | Second string | Score |
| --- | --- | --- |
| `same` | `same` | 1 |
| `abc` | `xyz` | 0 |
| `ab` | `ba` | 1 |
| Empty string | Empty string | 1 |

Use exact string comparison when you need to determine whether two strings are
identical. See the [Python documentation](https://docs.python.org/3/library/difflib.html#difflib.SequenceMatcher.quick_ratio)
for the distinction between `quick_ratio()` and `ratio()`.

## Examples

From the repository directory in Stata:

```stata
do examples/strquick_example.do
```

The file includes English and Chinese text, empty strings, reordered characters,
double quotes, and Windows-style paths. The current revision has not been run
in Stata; the example is provided for manual verification.

## Files

| File | Purpose |
| --- | --- |
| `strquick.ado` | Stata command and embedded Python implementation |
| `strquick.sthlp` | Help available through `help strquick` |
| `strquick.pkg`, `stata.toc` | Metadata for `net install` |
| `examples/strquick_example.do` | Runnable examples |
| `LICENSE` | MIT license |

## 中文说明

`strquick` 每次比较一对字符串，通过 `r(similarity)` 返回 0 到 1 的字符重合度估计。
它不是语义相似度，也不能用来判断两段文本是否完全相同；例如 `ab` 与 `ba` 都会得到 1。
安装后运行 `help strquick` 查看帮助。包含空格的文本需要加引号，包含双引号的文本使用
Stata 的复合双引号语法。命令不会自动清理空格、忽略大小写或处理整列数据。

## License

[MIT](LICENSE). Copyright (c) 2021–2026 Joo1024.
