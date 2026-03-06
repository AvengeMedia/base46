local theme = require("base46").current_theme
local base16 = require("base46").theme_tables[theme].base_16

return {
  ["@lsp.type.class"] = { link = "Structure" },
  ["@lsp.type.decorator"] = { link = "Function" },
  ["@lsp.type.enum"] = { link = "Type" },
  ["@lsp.type.enumMember"] = { link = "Constant" },
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.interface"] = { link = "Structure" },
  ["@lsp.type.macro"] = { link = "@macro" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.struct"] = { link = "Structure" },
  ["@lsp.type.type"] = { link = "@type" },
  ["@lsp.type.typeParamater"] = { link = "TypeDef" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@event"] = { fg = base16.base08 },
  ["@modifier"] = { fg = base16.base08 },
  ["@regexp"] = { fg = base16.base0F },
}
