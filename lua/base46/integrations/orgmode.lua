local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  ["@org.headline.level1.org"] = { fg = colors.red },
  ["@org.headline.level2.org"] = { fg = colors.orange },
  ["@org.headline.level3.org"] = { fg = colors.yellow },
  ["@org.headline.level4.org"] = { fg = colors.green },
  ["@org.headline.level5.org"] = { fg = colors.blue },
  ["@org.headline.level6.org"] = { fg = colors.purple },
}
