local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local M = {
  NvChHeading = {
    fg = colors.black,
    bg = colors.blue,
    bold = true,
  },

  NvChSection = {
    bg = colors.black2,
  },

  NvChAsciiHeader = {
    fg = colors.blue,
    bg = colors.black2,
  },
}

local cheatsheet_theme = require("base46").opts.nvchad.cheatsheet_theme

if cheatsheet_theme == "grid" then
  M.NvChAsciiHeader = {
    fg = colors.blue,
  }

  local bgcols =
    { "blue", "red", "green", "yellow", "orange", "baby_pink", "purple", "white", "cyan", "vibrant_green", "teal" }

  for _, value in ipairs(bgcols) do
    M["NvChHead" .. value] = {
      fg = colors.black,
      bg = colors[value],
    }
  end
end

return M
