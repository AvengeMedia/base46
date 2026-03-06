local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  AlphaHeader = { fg = colors.grey_fg },
  AlphaButtons = { fg = colors.light_grey },
}
