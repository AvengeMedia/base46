local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local mixcolors = require("base46.colors").mix

-- Need to manually re-configure git-conflict.nvim to use these highlight groups.
-- See: https://github.com/akinsho/git-conflict.nvim?tab=readme-ov-file#configuration
local highligths = {
  GitConflictDiffAdd = { bg = mixcolors(colors.blue, colors.black, 85) },
  GitConflictDiffText = { bg = mixcolors(colors.green, colors.black, 85) },
}

return highligths
