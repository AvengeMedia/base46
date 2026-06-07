local lighten = require("base46.colors").change_hex_lightness
local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30

return {
  GitSignsCurrentLineBlame = { fg = lighten(colors.light_grey, vim.o.bg == "dark" and 10 or -10) },
}
