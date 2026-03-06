local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30

local highligths = {
  BlinkPairsOrange = { fg = colors.orange },
  BlinkPairsPurple = { fg = colors.purple },
  BlinkPairsBlue = { fg = colors.blue },
  BlinkPairsRed = { fg = colors.red },
  BlinkPairsYellow = { fg = colors.yellow },
  BlinkPairsGreen = { fg = colors.green },
  BlinkPairsCyan = { fg = colors.cyan },
  BlinkPairsViolet = { fg = colors.dark_purple },

  BlinkPairsUnmatched = { fg = colors.red },
  BlinkPairsMatchParen = { fg = colors.cyan },
}

return highligths
