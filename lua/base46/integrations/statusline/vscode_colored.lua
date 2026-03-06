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

local M = {
  StatusLine = { fg = light_grey, bg = statusline_bg },
  StText = { fg = light_grey, bg = statusline_bg },
  -- LSP
  St_lspError = { fg = colors.red, bg = statusline_bg },
  St_lspWarning = { fg = colors.yellow, bg = statusline_bg },
  St_LspHints = { fg = colors.purple, bg = statusline_bg },
  St_Lsp = { fg = colors.green, bg = statusline_bg },
  St_LspMsg = { fg = colors.red, bg = statusline_bg },
  St_cwd = { fg = colors.red, bg = colors.one_bg3 },
  St_ft = { fg = colors.blue, bg = statusline_bg },
}

local function genModes_hl(modename, col)
  M["St_" .. modename .. "Mode"] = { fg = colors[col], bg = colors.one_bg3, bold = true }
end

genModes_hl("Normal", "blue")
genModes_hl("Visual", "cyan")
genModes_hl("Insert", "dark_purple")
genModes_hl("Terminal", "green")
genModes_hl("NTerminal", "yellow")
genModes_hl("Replace", "orange")
genModes_hl("Confirm", "teal")
genModes_hl("Command", "green")
genModes_hl("Select", "blue")

return M
