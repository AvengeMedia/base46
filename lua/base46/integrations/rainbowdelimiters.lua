local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  RainbowDelimiterRed = { fg = colors.red },
  RainbowDelimiterYellow = { fg = colors.yellow },
  RainbowDelimiterBlue = { fg = colors.blue },
  RainbowDelimiterOrange = { fg = colors.orange },
  RainbowDelimiterGreen = { fg = colors.green },
  RainbowDelimiterViolet = { fg = colors.purple },
  RainbowDelimiterCyan = { fg = colors.cyan },
}
