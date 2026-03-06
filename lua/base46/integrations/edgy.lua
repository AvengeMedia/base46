local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local highligths = {
  EdgyNormal = { fg = colors.white },
  EdgyWinBar = { fg = colors.white },
  EdgyWinBarInactive = { fg = colors.white },
}

return highligths
