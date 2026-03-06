local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  WhichKey = { fg = colors.blue },
  WhichKeySeparator = { fg = colors.light_grey },
  WhichKeyDesc = { fg = colors.red },
  WhichKeyGroup = { fg = colors.green },
  WhichKeyValue = { fg = colors.green },
}
