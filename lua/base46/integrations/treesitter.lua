local theme = require("base46").current_theme
local base16 = require("base46").theme_tables[theme].base_16
local base30 = require("base46").theme_tables[theme].base_30

local opts = require("base46").opts

return {

  ["@variable"] = { fg = base16.base05 },
  ["@variable.builtin"] = { fg = base16.base09 },
  ["@variable.parameter"] = { fg = base16.base08 },
  ["@variable.member"] = { fg = base16.base08 },
  ["@variable.member.key"] = { fg = base16.base08 },

  ["@module"] = { fg = base16.base08 },
  -- ["@module.builtin"] = { fg = base16.base08 },

  ["@constant"] = { fg = base16.base09 },
  ["@constant.builtin"] = { fg = base16.base09 },
  ["@constant.macro"] = { fg = base16.base08 },

  ["@string"] = { fg = base16.base0B },
  ["@string.regex"] = { fg = base16.base0C },
  ["@string.escape"] = { fg = base16.base0C },
  ["@character"] = { fg = base16.base08 },
  -- ["@character.special"] = { fg = base16.base08 },
  ["@number"] = { fg = base16.base09 },
  ["@number.float"] = { fg = base16.base09 },

  ["@annotation"] = { fg = base16.base0F },
  ["@attribute"] = { fg = base16.base0A },
  ["@error"] = { fg = base16.base08 },

  ["@keyword.exception"] = { fg = base16.base08 },
  ["@keyword"] = { fg = base16.base0E },
  ["@keyword.function"] = { fg = base16.base0E },
  ["@keyword.return"] = { fg = base16.base0E },
  ["@keyword.operator"] = { fg = base16.base0E },
  ["@keyword.import"] = { link = "Include" },
  ["@keyword.conditional"] = { fg = base16.base0E },
  ["@keyword.conditional.ternary"] = { fg = base16.base0E },
  ["@keyword.repeat"] = { fg = base16.base0A },
  ["@keyword.storage"] = { fg = base16.base0A },
  ["@keyword.directive.define"] = { fg = base16.base0E },
  ["@keyword.directive"] = { fg = base16.base0A },

  ["@function"] = { fg = base16.base0D },
  ["@function.builtin"] = { fg = base16.base0D },
  ["@function.macro"] = { fg = base16.base08 },
  ["@function.call"] = { fg = base16.base0D },
  ["@function.method"] = { fg = base16.base0D },
  ["@function.method.call"] = { fg = base16.base0D },
  ["@constructor"] = { fg = base16.base0C },

  ["@operator"] = { fg = base16.base05 },
  ["@reference"] = { fg = base16.base05 },
  ["@punctuation.bracket"] = { fg = base16.base0F },
  ["@punctuation.delimiter"] = { fg = base16.base0F },
  ["@symbol"] = { fg = base16.base0B },
  ["@tag"] = { fg = base16.base0A },
  ["@tag.attribute"] = { fg = base16.base08 },
  ["@tag.delimiter"] = { fg = base16.base0F },
  ["@text"] = { fg = base16.base05 },
  ["@text.emphasis"] = { fg = base16.base09 },
  ["@text.strike"] = { fg = base16.base0F, strikethrough = true },
  ["@type.builtin"] = { fg = base16.base0A },
  ["@definition"] = { sp = base16.base04, underline = true },
  ["@scope"] = { bold = true },
  ["@property"] = { fg = base16.base08 },

  -- markup
  ["@markup.heading"] = { fg = base16.base0D },
  ["@markup.raw"] = { fg = base16.base09 },
  ["@markup.link"] = { fg = base16.base08 },
  ["@markup.link.url"] = { fg = base16.base09, underline = true },
  ["@markup.link.label"] = { fg = base16.base0C },
  ["@markup.list"] = { fg = base16.base08 },
  ["@markup.strong"] = { bold = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.quote"] = { bg = opts.transparency and nil or base30.black2 },

  ["@comment"] = { fg = base30.grey_fg },
  ["@comment.todo"] = { fg = base30.grey, bg = base30.white },
  ["@comment.warning"] = { fg = base30.black2, bg = base16.base09 },
  ["@comment.note"] = { fg = base30.black, bg = base30.blue },
  ["@comment.danger"] = { fg = base30.black2, bg = base30.red },

  ["@diff.plus"] = { fg = base30.green },
  ["@diff.minus"] = { fg = base30.red },
  ["@diff.delta"] = { fg = base30.light_grey },
}
