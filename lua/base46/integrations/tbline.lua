local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30

local highlights = {
  Tabline = { bg = colors.black2 },

  TbFill = {
    bg = colors.black2,
  },

  TbBufOn = {
    fg = colors.white,
    bg = colors.black,
  },

  TbBufOff = {
    fg = colors.light_grey,
    bg = colors.black2,
  },

  TbBufOnModified = {
    fg = colors.green,
    bg = colors.black,
  },

  TbBufOffModified = {
    fg = colors.red,
    bg = colors.black2,
  },

  TbBufOnClose = {
    fg = colors.red,
    bg = colors.black,
  },

  TbBufOffClose = {
    fg = colors.light_grey,
    bg = colors.black2,
  },

  TbTabNewBtn = {
    fg = colors.white,
    bg = colors.one_bg2,
  },

  TbTabOn = {
    fg = colors.red,
    bg = colors.black,
  },

  TbTabOff = {
    fg = colors.white,
    bg = colors.black2,
  },

  TbTabCloseBtn = {
    fg = colors.black,
    bg = colors.nord_blue,
  },

  TBTabTitle = {
    fg = colors.black,
    bg = colors.blue,
  },

  TbThemeToggleBtn = {
    bold = true,
    fg = colors.white,
    bg = colors.one_bg3,
  },

  TbCloseAllBufsBtn = {
    bold = true,
    bg = colors.red,
    fg = colors.black,
  },
}

local hlgroups_glassy = {
  "Tabline",
  "TbFill",
  "TbBufOn",
  "TbBufOff",
  "TbBufOnClose",
  "TbBufOffClose",
  "TbBufOnModified",
  "TbBufOffModified",
}

if require("base46").opts.transparency then
  for _, val in ipairs(hlgroups_glassy) do
    highlights[val].bg = "NONE"
  end
end

return highlights
