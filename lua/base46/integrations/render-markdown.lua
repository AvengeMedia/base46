local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local mix = require("base46.colors").mix

return {
  ["@markup.heading.1.markdown"] = { fg = colors.red },
  ["@markup.heading.2.markdown"] = { fg = colors.orange },
  ["@markup.heading.3.markdown"] = { fg = colors.yellow },
  ["@markup.heading.4.markdown"] = { fg = colors.green },
  ["@markup.heading.5.markdown"] = { fg = colors.blue },
  ["@markup.heading.6.markdown"] = { fg = colors.purple },

  RenderMarkdownH1Bg = { bg = mix(colors.blue, colors.black, 90) },
  RenderMarkdownH2Bg = { bg = mix(colors.yellow, colors.black, 90) },
  RenderMarkdownH3Bg = { bg = mix(colors.green, colors.black, 90) },
  RenderMarkdownH4Bg = { bg = mix(colors.teal, colors.black, 90) },
  RenderMarkdownH5Bg = { bg = mix(colors.purple, colors.black, 90) },
  RenderMarkdownH6Bg = { bg = mix(colors.pink, colors.black, 90) },
}
