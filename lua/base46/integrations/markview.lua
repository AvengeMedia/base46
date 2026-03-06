local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
return {
  ["@markup.heading.1.markdown"] = { fg = colors.red },
  ["@markup.heading.2.markdown"] = { fg = colors.orange },
  ["@markup.heading.3.markdown"] = { fg = colors.yellow },
  ["@markup.heading.4.markdown"] = { fg = colors.green },
  ["@markup.heading.5.markdown"] = { fg = colors.blue },
  ["@markup.heading.6.markdown"] = { fg = colors.purple },
}
