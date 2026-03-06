local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  FlashMatch = { fg = colors.black, bg = colors.blue },
  FlashCurrent = { fg = colors.black, bg = colors.green },
  FlashLabel = { fg = colors.white, bold = true },
}
