local theme_tables = require("base46").theme_tables
local theme = require("base46").current_theme
local theme_type = theme_tables[theme].type
local colors = theme_tables[theme].base_30
local lighten = require("base46.colors").change_hex_lightness

local statusline_bg = require("base46").opts.transparency and "NONE" or lighten(colors.statusline_bg, 1)
local light_grey = lighten(colors.light_grey, 8)

if theme_type == "light" then
  light_grey = lighten(colors.light_grey, -15)
end

return {
  StatusLine = { fg = light_grey, bg = statusline_bg },
  St_Mode = { fg = light_grey, bg = colors.one_bg2 },
  StText = { fg = light_grey, bg = statusline_bg },
}
