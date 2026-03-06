local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  LeapBackdrop = { fg = colors.grey_fg },
  LeapLabel = { fg = colors.yellow, bold = true },
  LeapMatch = { fg = colors.yellow, bold = true },
}
