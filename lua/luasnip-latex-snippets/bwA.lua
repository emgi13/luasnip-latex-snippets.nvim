local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node

local M = {}

function M.retrieve(not_math)
  local utils = require("luasnip-latex-snippets.util.utils")
  local pipe = utils.pipe

  local conds = require("luasnip.extras.expand_conditions")
  local condition = pipe({ conds.line_begin, not_math })

  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    condition = condition,
  }) --[[@as function]]

  local s = ls.extend_decorator.apply(ls.snippet, {
    condition = condition,
  }) --[[@as function]]

  return {
    s(
      { trig = "ali", name = "Align" },
      { t({ "\\begin{align*}", "\t" }), i(1), t({ "", ".\\end{align*}" }) }
    ),

    parse_snippet({ trig = "beg", name = "begin{} / end{}" }, "\\begin{$1}\n\t$0\n\\end{$1}"),

    s({ trig = "bigfun", name = "Big function" }, {
      t({ "\\begin{align*}", "\t" }),
      i(1),
      t(":"),
      t(" "),
      i(2),
      t("&\\longrightarrow "),
      i(3),
      t({ " \\", "\t" }),
      i(4),
      t("&\\longmapsto "),
      i(1),
      t("("),
      i(4),
      t(")"),
      t(" = "),
      i(0),
      t({ "", ".\\end{align*}" }),
    }),

    parse_snippet(
      { trig = "DOCUMENT", name = "Complete LaTeX Boilerplate with amsthm and cleveref" },
      [[\documentclass{article}
\usepackage[margin=1.5cm]{geometry}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{dsfont}
\usepackage{physics}
\usepackage{amsthm}
\usepackage{natbib}
\usepackage{hyperref}

% --- Theorem Environments ---

% 1. Plain Style - Theorems and proofs share a counter
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}

% 2. Definition Style - Independent counters, tied to section
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]
\newtheorem{example}{Example}[section]
\newtheorem{exercise}{Exercise}[section]

% 3. Remark Style - Independent counter, tied to section
\theoremstyle{remark}
\newtheorem{remark}{Remark}[section]

% --- Document Information ---
\title{${1:Document Title}}
\author{${2:emgixiii}}
\date{${3:\today}}

\begin{document}
\maketitle

$0

\end{document}]]
    ),
    parse_snippet(
      { trig = "BLE", name = "Lemma" },
      [[\begin{lemma}[$2]\label{lem:${1:Label}}
${3:Statement}
\end{lemma}

$0]]
    ),
    parse_snippet(
      { trig = "BTH", name = "Theorem" },
      [[\begin{theorem}[$2]\label{thm:${1:Label}}
${3:Statement}
\end{theorem}

$0]]
    ),
    parse_snippet(
      { trig = "BDE", name = "Definition" },
      [[\begin{definition}[$2]\label{def:${1:Label}}
${3:Statement}
\end{definition}

$0]]
    ),
    parse_snippet(
      { trig = "BCO", name = "Corollary" },
      [[\begin{corollary}[$2]\label{cor:${1:Label}}
${3:Statement}
\end{corollary}

$0]]
    ),
    parse_snippet(
      { trig = "BEX", name = "Example" },
      [[\begin{example}[$2]\label{ex:${1:Label}}
${3:Statement}
\end{example}

$0]]
    ),
    parse_snippet(
      { trig = "BRE", name = "Remark" },
      [[\begin{remark}[$2]\label{rem:${1:Label}}
${3:Statement}
\end{remark}

$0]]
    ),
    parse_snippet(
      { trig = "BQE", name = "Exercise" },
      [[\begin{exercise}[$2]\label{exr:${1:Label}}
${3:Statement}
\end{exercise}

$0]]
    ),
    parse_snippet(
      { trig = "BPR", name = "Proof" },
      [[\begin{proof}
${1:Statement}
\end{proof}

$0]]
    ),
    parse_snippet(
      { trig = "BPP", name = "Proposition" },
      [[\begin{proposition}[$2]\label{prop:${1:Label}}
${3:Statement}
\end{proposition}

$0]]
    ),
  }
end

return M
