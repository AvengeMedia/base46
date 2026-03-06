local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local colorize = require("base46.colors").change_hex_lightness

return {
  -- LSP References
  LspReferenceText = { bg = colors.one_bg3 },
  LspReferenceRead = { bg = colors.one_bg3 },
  LspReferenceWrite = { bg = colors.one_bg3 },

  -- Lsp Diagnostics
  DiagnosticHint = { fg = colors.purple },
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.yellow },
  DiagnosticInfo = { fg = colors.green },
  LspSignatureActiveParameter = { fg = colors.black, bg = colors.green },

  LspInlayHint = {
    bg = colorize(colors.black2, vim.o.bg == "dark" and 0 or 3),
    fg = colors.light_grey,
  },
}
