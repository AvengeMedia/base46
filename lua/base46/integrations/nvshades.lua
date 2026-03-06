local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  NvShTitle = { bg = colors.one_bg3, fg = colors.white },
}
