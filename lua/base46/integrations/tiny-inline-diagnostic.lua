local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local mixcolors = require("base46.colors").mix

local highligths = {
  TinyInlineDiagnosticVirtualTextArrow = { fg = colors.white, bg = colors.black },

  TinyInlineDiagnosticVirtualTextError = { fg = colors.red, bg = mixcolors(colors.red, colors.black, 75) },
  TinyInlineDiagnosticVirtualTextWarn = { fg = colors.yellow, bg = mixcolors(colors.yellow, colors.black, 75) },
  TinyInlineDiagnosticVirtualTextInfo = { fg = colors.green, bg = mixcolors(colors.green, colors.black, 75) },
  TinyInlineDiagnosticVirtualTextHint = { fg = colors.purple, bg = mixcolors(colors.purple, colors.black, 75) },

  TinyInlineInvDiagnosticVirtualTextError = { fg = mixcolors(colors.red, colors.black, 75), bg = colors.black },
  TinyInlineInvDiagnosticVirtualTextWarn = { fg = mixcolors(colors.yellow, colors.black, 75), bg = colors.black },
  TinyInlineInvDiagnosticVirtualTextInfo = { fg = mixcolors(colors.green, colors.black, 75), bg = colors.black },
  TinyInlineInvDiagnosticVirtualTextHint = { fg = mixcolors(colors.purple, colors.black, 75), bg = colors.black },
}

return highligths
