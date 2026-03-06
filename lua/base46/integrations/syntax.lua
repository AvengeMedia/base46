local theme = require("base46").current_theme
local base16 = require("base46").theme_tables[theme].base_16

local syntax = {
  Boolean = { fg = base16.base09 },
  Character = { fg = base16.base08 },
  Conditional = { fg = base16.base0E },
  Constant = { fg = base16.base09 },
  Define = { fg = base16.base0E, sp = "none" },
  Delimiter = { fg = base16.base0F },
  Float = { fg = base16.base09 },
  Variable = { fg = base16.base05 },
  Function = { fg = base16.base0D },
  Identifier = { fg = base16.base08, sp = "none" },
  Include = { fg = base16.base0D },
  Keyword = { fg = base16.base0E },
  Label = { fg = base16.base0A },
  Number = { fg = base16.base09 },
  Operator = { fg = base16.base05, sp = "none" },
  PreProc = { fg = base16.base0A },
  Repeat = { fg = base16.base0A },
  Special = { fg = base16.base0C },
  SpecialChar = { fg = base16.base0F },
  Statement = { fg = base16.base08 },
  StorageClass = { fg = base16.base0A },
  String = { fg = base16.base0B },
  Structure = { fg = base16.base0E },
  Tag = { fg = base16.base0A },
  Todo = { fg = base16.base0A, bg = base16.base01 },
  Type = { fg = base16.base0A, sp = "none" },
  Typedef = { fg = base16.base0A },
}

return syntax
