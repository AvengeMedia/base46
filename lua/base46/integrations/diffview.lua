local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local mixcolors = require("base46.colors").mix

local highligths = {
  -- DiffviewDiffAdd = { bg = mix_col(colors.green, colors.black, 85) },
  -- DiffviewDiffText = { bg = mix_col(colors.green, colors.black, 70) },
  -- DiffviewDiffChange = { bg = mix_col(colors.green, colors.black, 85) },
  -- DiffviewDiffDelete = { bg = mix_col(colors.red, colors.black, 70) },
  DiffviewDiffDeleteDim = { bg = mixcolors(colors.red, colors.black, 85) },
  DiffviewDiffAddAsDelete = { bg = mixcolors(colors.red, colors.black, 85) },
}

return highligths
