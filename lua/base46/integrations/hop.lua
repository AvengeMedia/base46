local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  HopNextKey = { fg = colors.red, bold = true },
  HopNextKey1 = { fg = colors.cyan, bold = true },
  HopNextKey2 = { fg = colors.blue, bold = true },
}
