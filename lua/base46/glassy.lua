return function(theme)
  local colors = require("base46").theme_tables[theme].base_30

  local M = {
    NvimTreeWinSeparator = {
      fg = colors.one_bg2,
      bg = "NONE",
    },

    TelescopeResultsTitle = {
      fg = colors.black,
      bg = colors.blue,
    },

    TelescopeBorder = {
      fg = colors.grey,
      bg = "NONE",
    },

    TelescopePromptBorder = {
      fg = colors.grey,
      bg = "NONE",
    },

    CmpDocBorder = {
      fg = colors.grey,
      bg = "NONE",
    },

    BlinkCmpDocBorder = {
      fg = colors.grey,
      bg = "NONE",
    },

    BlinkCmpMenuBorder = {
      fg = colors.grey,
      bg = "NONE",
    },
  }

  -- hl groups that only need bg = "NONE"
  local hl_groups = {
    "NormalFloat",
    "Normal",
    "Folded",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "NvimTreeCursorLine",
    "TelescopeNormal",
    "TelescopePrompt",
    "TelescopeResults",
    "TelescopePromptNormal",
    "TelescopePromptPrefix",
    "CursorLine",
    "Pmenu",
    "BlinkCmpMenu",
    "BlinkCmpDoc",
    "BlinkCmpSignatureHelp",
    "CmpPmenu",
    "CmpDoc",
    "WinBar",
    "WinBarNC",
  }

  for _, groups in ipairs(hl_groups) do
    M[groups] = {
      bg = "NONE",
    }
  end

  return M
end
