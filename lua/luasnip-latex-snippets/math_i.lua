-- Math Insert
local M = {}

local ls = require("luasnip")
local utils = require("luasnip-latex-snippets.util.utils")
local pipe = utils.pipe

function M.retrieve(is_math)
  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    wordTrig = false,
    condition = pipe({ is_math }),
    show_condition = is_math,
  }) --[[@as function]]

  return {
    parse_snippet({ trig = "sum", name = "sum" }, "\\sum_{n=${1:1}}^{${2:\\infty}} ${3:a_n z^n}"),

    parse_snippet(
      { trig = "taylor", name = "taylor" },
      "\\sum_{${1:k}=${2:0}}^{${3:\\infty}} ${4:c_$1} (x-a)^$1 $0"
    ),

    parse_snippet({ trig = "lim", name = "limit" }, "\\lim_{${1:n} \\to ${2:\\infty}} "),
    parse_snippet({ trig = "limsup", name = "limsup" }, "\\limsup_{${1:n} \\to ${2:\\infty}} "),

    parse_snippet(
      { trig = "prod", name = "product" },
      "\\prod_{${1:n=${2:1}}}^{${3:\\infty}} ${4:${TM_SELECTED_TEXT}} $0"
    ),

    parse_snippet(
      { trig = "part", name = "d/dx" },
      "\\frac{\\partial ${1:V}}{\\partial ${2:x}} $0"
    ),
    parse_snippet(
      { trig = "ddx", name = "d/dx" },
      "\\frac{\\mathrm{d${1:V}}}{\\mathrm{d${2:x}}} $0"
    ),

    parse_snippet({ trig = "pmat", name = "pmat" }, "\\begin{pmatrix} $1 \\end{pmatrix} $0"),

    parse_snippet(
      { trig = "sequence", name = "Sequence indexed by n, from m to infinity" },
      "(${1:a}_${2:n})_{${2:n}=${3:m}}^{${4:\\infty}}"
    ),
  }
end

return M
