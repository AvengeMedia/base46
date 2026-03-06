local theme = require("base46").current_theme
local base16 = require("base46").theme_tables[theme].base_16
local colors = require("base46").theme_tables[theme].base_30
local mix = require("base46.colors").mix

return {

  diffOldFile = {
    fg = colors.baby_pink,
  },

  diffNewFile = {
    fg = colors.blue,
  },

  DiffAdd = {
    bg = mix(colors.green, colors.black, 90),
    fg = colors.green,
  },

  DiffAdded = {
    bg = mix(colors.green, colors.black, 90),
    fg = colors.green,
  },

  DiffChange = {
    bg = mix(colors.light_grey, colors.black, 90),
    fg = colors.light_grey,
  },

  DiffChangeDelete = {
    bg = mix(colors.red, colors.black, 90),
    fg = colors.red,
  },

  DiffModified = {
    bg = mix(colors.orange, colors.black, 90),
    fg = colors.orange,
  },

  DiffDelete = {
    bg = mix(colors.red, colors.black, 90),
    fg = colors.red,
  },

  DiffRemoved = {
    bg = mix(colors.red, colors.black, 90),
    fg = colors.red,
  },

  DiffText = {
    fg = colors.white,
    bg = colors.black2,
  },

  -- git commits
  gitcommitOverflow = {
    fg = base16.base08,
  },

  gitcommitSummary = {
    fg = base16.base0B,
  },

  gitcommitComment = {
    fg = base16.base03,
  },

  gitcommitUntracked = {
    fg = base16.base03,
  },

  gitcommitDiscarded = {
    fg = base16.base03,
  },

  gitcommitSelected = {
    fg = base16.base03,
  },

  gitcommitHeader = {
    fg = base16.base0E,
  },

  gitcommitSelectedType = {
    fg = base16.base0D,
  },

  gitcommitUnmergedType = {
    fg = base16.base0D,
  },

  gitcommitDiscardedType = {
    fg = base16.base0D,
  },

  gitcommitBranch = {
    fg = base16.base09,
    bold = true,
  },

  gitcommitUntrackedFile = {
    fg = base16.base0A,
  },

  gitcommitUnmergedFile = {
    fg = base16.base08,
    bold = true,
  },

  gitcommitDiscardedFile = {
    fg = base16.base08,
    bold = true,
  },

  gitcommitSelectedFile = {
    fg = base16.base0B,
    bold = true,
  },
}
