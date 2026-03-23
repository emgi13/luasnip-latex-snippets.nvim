local M = {}

local ls = require("luasnip")
local f = ls.function_node

function M.retrieve(is_math)
  local utils = require("luasnip-latex-snippets.util.utils")
  local pipe, no_backslash = utils.pipe, utils.no_backslash

  local decorator = {
    wordTrig = false,
    condition = pipe({ is_math, no_backslash }),
  }

  local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, decorator) --[[@as function]]
  local s = ls.extend_decorator.apply(ls.snippet, decorator) --[[@as function]]

  return {
    s(
      {
        trig = "(%a+)est",
        wordTrig = false,
        regTrig = true,
        name = "est",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\tilde{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)bar",
        wordTrig = false,
        regTrig = true,
        name = "bar",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\overline{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)und",
        wordTrig = false,
        regTrig = true,
        name = "underline",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\underline{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a)dot",
        wordTrig = false,
        regTrig = true,
        name = "dot",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\dot{%s}", snip.captures[1])
      end, {})
    ),

    s(
      {
        trig = "(%a+)hat",
        wordTrig = false,
        regTrig = true,
        name = "hat",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\hat{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)ket",
        wordTrig = false,
        regTrig = true,
        name = "ket",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\ket{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)bra",
        wordTrig = false,
        regTrig = true,
        name = "bra",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\bra{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)ora",
        wordTrig = false,
        regTrig = true,
        name = "ora",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\overrightarrow{%s}", snip.captures[1])
      end, {})
    ),
    s(
      {
        trig = "(%a+)ola",
        wordTrig = false,
        regTrig = true,
        name = "ola",
        priority = 100,
      },
      f(function(_, snip)
        return string.format("\\overleftarrow{%s}", snip.captures[1])
      end, {})
    ),

    parse_snippet({ trig = "td", name = "to the ... power ^{}" }, "^{$1}$0 "),
    parse_snippet({ trig = "rd", name = "to the ... power ^{()}" }, "^{($1)}$0 "),
    parse_snippet({ trig = "cb", name = "Cube ^3" }, "^3 "),
    parse_snippet({ trig = "sr", name = "Square ^2" }, "^2"),

    parse_snippet({ trig = "EE", name = "exists" }, "\\exists "),
    parse_snippet({ trig = "AA", name = "forall" }, "\\forall "),
    parse_snippet({ trig = "xnn", name = "xn" }, "x_{n}"),
    parse_snippet({ trig = "ynn", name = "yn" }, "y_{n}"),
    parse_snippet({ trig = "xii", name = "xi" }, "x_{i}"),
    parse_snippet({ trig = "yii", name = "yi" }, "y_{i}"),
    parse_snippet({ trig = "xjj", name = "xj" }, "x_{j}"),
    parse_snippet({ trig = "yjj", name = "yj" }, "y_{j}"),
    parse_snippet({ trig = "xp1", name = "x" }, "x_{n+1}"),
    parse_snippet({ trig = "xmm", name = "x" }, "x_{m}"),
    parse_snippet({ trig = "R0+", name = "R0+" }, "\\mathbb{R}_0^+"),

    parse_snippet({ trig = "notin", name = "not in " }, "\\not\\in "),

    parse_snippet({ trig = "cc", name = "subset" }, "\\subset "),

    parse_snippet({ trig = "<->", name = "leftrightarrow", priority = 200 }, "\\leftrightarrow"),
    parse_snippet({ trig = "...", name = "ldots", priority = 100 }, "\\ldots "),
    parse_snippet({ trig = "!>", name = "mapsto" }, "\\mapsto "),
    parse_snippet({ trig = "iff", name = "iff" }, "\\iff"),
    parse_snippet({ trig = "siff", name = "short iff", priority = 100 }, "\\Leftrightarrow"),
    parse_snippet({ trig = "ooo", name = "\\infty" }, "\\infty"),
    parse_snippet({ trig = "rij", name = "mrij" }, "(${1:x}_${2:n})_{${3:$2}\\in${4:\\N}}$0"),
    parse_snippet({ trig = "nabl", name = "nabla" }, "\\nabla "),
    parse_snippet({ trig = "<!", name = "normal" }, "\\triangleleft "),
    parse_snippet({ trig = "floor", name = "floor" }, "\\left\\lfloor $1 \\right\\rfloor$0"),
    parse_snippet({ trig = "mcal", name = "mathcal" }, "\\mathcal{$1}$0"),
    parse_snippet({ trig = "//", name = "Fraction" }, "\\frac{$1}{$2}$0"),
    parse_snippet({ trig = "\\\\\\", name = "setminus" }, "\\setminus"),
    parse_snippet({ trig = "->", name = "to", priority = 100 }, "\\to "),
    parse_snippet({ trig = "-->", name = "long to", priority = 200 }, "\\longrightarrow "),

    parse_snippet({ trig = "letw", name = "let omega" }, "Let $\\Omega \\subset \\C$ be open."),
    parse_snippet({ trig = "nnn", name = "bigcap" }, "\\bigcap_{${1:i \\in ${2: I}}} $0"),
    parse_snippet({ trig = "norm", name = "norm" }, "\\|$1\\|$0"),
    parse_snippet({ trig = "<>", name = "hokje" }, "\\diamond "),
    parse_snippet({ trig = ">>", name = ">>" }, "\\gg"),
    parse_snippet({ trig = "<<", name = "<<" }, "\\ll"),

    parse_snippet({ trig = "stt", name = "text subscript" }, "_\\text{$1} $0"),
    parse_snippet({ trig = "tt", name = "text" }, "\\text{$1}$0"),

    parse_snippet({ trig = "oxx", name = "otimes" }, "\\otimes "),
    parse_snippet({ trig = "xx", name = "cross" }, "\\times "),

    parse_snippet({ trig = "**", name = "cdot", priority = 100 }, "\\cdot "),

    parse_snippet({ trig = ":=", name = "colon equals (lhs defined as rhs)" }, "\\coloneqq "),

    parse_snippet(
      { trig = "cvec", name = "column vector" },
      "\\begin{pmatrix} ${1:x}_${2:1}\\\\ \\vdots\\\\ $1_${2:n} \\end{pmatrix}"
    ),
    parse_snippet({ trig = "ceil", name = "ceil" }, "\\left\\lceil $1 \\right\\rceil $0"),
    parse_snippet({ trig = "floor", name = "floor" }, "\\left\\lfloor $1 \\right\\rfloor $0"),
    parse_snippet({ trig = "OO", name = "emptyset" }, "\\O"),
    parse_snippet({ trig = "RR", name = "R" }, "\\mathbb{R}"),
    parse_snippet({ trig = "CC", name = "C" }, "\\mathbb{C}"),
    parse_snippet({ trig = "QQ", name = "Q" }, "\\mathbb{Q}"),
    parse_snippet({ trig = "ZZ", name = "Z" }, "\\mathbb{Z}"),
    parse_snippet({ trig = "FF", name = "Field" }, "\\mathbb{F}"),
    parse_snippet({ trig = "UU", name = "cup" }, "\\cup "),
    parse_snippet({ trig = "NN", name = "n" }, "\\mathbb{N}"),
    parse_snippet({ trig = "||", name = "mid" }, " \\mid "),
    parse_snippet({ trig = "Nn", name = "cap" }, "\\cap "),
    parse_snippet({ trig = "bmat", name = "bmat" }, "\\begin{bmatrix} $1 \\end{bmatrix}$0"),
    parse_snippet({ trig = "uuu", name = "bigcup" }, "\\bigcup_{${1:i \\in ${2: I}}}$0"),
    parse_snippet({ trig = "DD", name = "D" }, "\\mathbb{D}"),
    parse_snippet({ trig = "HH", name = "H" }, "\\mathbb{H}"),
    parse_snippet({ trig = "II", name = "Indicator" }, "\\mathds{1}"),
    parse_snippet({ trig = "lll", name = "l" }, "\\ell"),
    parse_snippet(
      { trig = "dint", name = "integral", priority = 300 },
      "\\int_{${1:-\\infty}}^{${2:\\infty}} ${3:${TM_SELECTED_TEXT}}$0"
    ),

    parse_snippet({ trig = "==", name = "equals" }, [[&= $1 \\\\]]),
    parse_snippet({ trig = "!=", name = "not equals" }, "\\neq "),
    parse_snippet({ trig = "compl", name = "complement" }, "^{c}"),
    parse_snippet({ trig = "__", name = "subscript" }, "_{$1}$0"),
    parse_snippet({ trig = "^^", name = "superscript" }, "^{$1}$0"),
    parse_snippet({ trig = "=>", name = "implies" }, "\\implies"),
    parse_snippet({ trig = "simp", name = "short implies" }, "\\Rightarrow"),
    parse_snippet({ trig = "=<", name = "implied by" }, "\\impliedby"),
    parse_snippet({ trig = "<<", name = "<<" }, "\\ll "),

    parse_snippet({ trig = "<=", name = "leq" }, "\\le "),
    parse_snippet({ trig = ">=", name = "geq" }, "\\ge "),
    parse_snippet({ trig = "invs", name = "inverse" }, "^{-1}"),
    parse_snippet({ trig = "~~", name = "~" }, "\\sim "),
    parse_snippet({ trig = "conj", name = "conjugate" }, "\\overline{$1}$0"),

    -- Equivalent
    parse_snippet({ trig = "eqq", name = "Equiv" }, "\\equiv "),

    -- Brackets
    parse_snippet({ trig = "@)", name = "Round Bracket" }, "\\left( $1 \\right)$0"),
    parse_snippet({ trig = "@]", name = "Square Bracket" }, "\\left[ $1 \\right]$0"),
    parse_snippet({ trig = "@}", name = "Curve Bracket" }, "\\left\\{ $1 \\right\\\\}$0"),
    parse_snippet({ trig = "@>", name = "Angle Bracket" }, "\\left\\langle $1 \\right\\rangle$0"),

    -- Easy greek alphabets

    parse_snippet({ trig = "@a", name = "alpha" }, "\\alpha "),
    parse_snippet({ trig = "@A", name = "Alpha" }, "\\Alpha "),
    parse_snippet({ trig = "@b", name = "beta" }, "\\beta "),
    parse_snippet({ trig = "@B", name = "Beta" }, "\\Beta "),
    parse_snippet({ trig = "@c", name = "chi" }, "\\chi "),
    parse_snippet({ trig = "@C", name = "Chi" }, "\\Chi "),
    parse_snippet({ trig = "@d", name = "delta" }, "\\delta "),
    parse_snippet({ trig = "@D", name = "Delta" }, "\\Delta "),
    parse_snippet({ trig = "@e", name = "epsilon" }, "\\epsilon "),
    parse_snippet({ trig = "@E", name = "Epsilon" }, "\\Epsilon "),
    parse_snippet({ trig = "@g", name = "gamma" }, "\\gamma "),
    parse_snippet({ trig = "@G", name = "Gamma" }, "\\Gamma "),
    parse_snippet({ trig = "@i", name = "iota" }, "\\iota "),
    parse_snippet({ trig = "@I", name = "Iota" }, "\\Iota "),
    parse_snippet({ trig = "@k", name = "kappa" }, "\\kappa "),
    parse_snippet({ trig = "@K", name = "Kappa" }, "\\Kappa "),
    parse_snippet({ trig = "@l", name = "lambda" }, "\\lambda "),
    parse_snippet({ trig = "@L", name = "Lambda" }, "\\Lambda "),
    parse_snippet({ trig = "@m", name = "mu" }, "\\mu "),
    parse_snippet({ trig = "@M", name = "Mu" }, "\\Mu "),
    parse_snippet({ trig = "@n", name = "nu" }, "\\nu "),
    parse_snippet({ trig = "@N", name = "Nu" }, "\\Nu "),
    parse_snippet({ trig = "@o", name = "omega" }, "\\omega "),
    parse_snippet({ trig = "@O", name = "Omega" }, "\\Omega "),
    parse_snippet({ trig = "@p", name = "pi" }, "\\pi "),
    parse_snippet({ trig = "@P", name = "Pi" }, "\\Pi "),
    parse_snippet({ trig = "@f", name = "phi" }, "\\phi "),
    parse_snippet({ trig = "@F", name = "Phi" }, "\\Phi "),
    parse_snippet({ trig = "@y", name = "psi" }, "\\psi "),
    parse_snippet({ trig = "@Y", name = "Psi" }, "\\Psi "),
    parse_snippet({ trig = "@r", name = "rho" }, "\\rho "),
    parse_snippet({ trig = "@R", name = "Rho" }, "\\Rho "),
    parse_snippet({ trig = "@s", name = "sigma" }, "\\sigma "),
    parse_snippet({ trig = "@S", name = "Sigma" }, "\\Sigma "),
    parse_snippet({ trig = "@t", name = "tau" }, "\\tau "),
    parse_snippet({ trig = "@T", name = "Tau" }, "\\Tau "),
    parse_snippet({ trig = "@q", name = "theta" }, "\\theta "),
    parse_snippet({ trig = "@Q", name = "Theta" }, "\\Theta "),
    parse_snippet({ trig = "@z", name = "zeta" }, "\\zeta "),
    parse_snippet({ trig = "@Z", name = "Zeta" }, "\\Zeta "),
    parse_snippet({ trig = "@e", name = "eta" }, "\\eta "),
    parse_snippet({ trig = "@E", name = "Eta" }, "\\Eta "),
    parse_snippet({ trig = "@u", name = "upsilon" }, "\\upsilon "),
    parse_snippet({ trig = "@U", name = "Upsilon" }, "\\Upsilon "),
    parse_snippet({ trig = "@x", name = "xi" }, "\\xi "),
    parse_snippet({ trig = "@X", name = "Xi" }, "\\Xi "),

    parse_snippet({ trig = "@ve", name = "varepsilon" }, "\\varepsilon "),
    parse_snippet({ trig = "@vf", name = "varphi" }, "\\varphi "),
    parse_snippet({ trig = "@vq", name = "vartheta" }, "\\vartheta "),
    parse_snippet({ trig = "@vk", name = "varkappa" }, "\\varkappa "),
    parse_snippet({ trig = "@vp", name = "varpi" }, "\\varpi "),
    parse_snippet({ trig = "@vr", name = "varrho" }, "\\varrho "),
    parse_snippet({ trig = "@vs", name = "varsigma" }, "\\varsigma "),

    -- Easy And and Or etc
    parse_snippet({ trig = "@6", name = "partial" }, "\\partial "),
    parse_snippet({ trig = "@&", name = "logical and" }, "\\land "),
    parse_snippet({ trig = "@|", name = "logical or" }, "\\lor "),
    parse_snippet({ trig = "@0", name = "Empty Set" }, "\\emptyset "),

    -- PSD operators
    parse_snippet({ trig = "psd", name = "succeq" }, "\\succeq "),
    parse_snippet({ trig = "pd", name = "succeq" }, "\\succ "),
    parse_snippet({ trig = "nsd", name = "succeq" }, "\\preceq "),
    parse_snippet({ trig = "nd", name = "succeq" }, "\\preq "),
  }
end

return M
