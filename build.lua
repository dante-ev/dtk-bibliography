module = "dtk-bibliography"

-- Typeset only the TeX files
typesetfiles = { "*.tex" }

-- Source files
bibfiles = {
  "dtk-bibliography.bib",
}
docfiles = {
  "dtk-bibliography.tex",
}
sourcefiles = {
  "dtk-authoryear.bbx",
  "dtk-authoryear.dbx",
  "dtk-logos.sty",
}

-- Use LuaLaTeX for compiling
typesetexe = "lualatex"

-- Define an upload config
uploadconfig = {
  pkg        = "dtk-bibliography",
  version    = "2026.1",
  author     = "Stephan Lukasczyk",
  license    = "lppl1.3c",
  summary    = "",
  ctanPath   = "/info/dtk-bibliography",
  repository = "https://github.com/dante-ev/dtk-bibliography",
  update     = true,
}
