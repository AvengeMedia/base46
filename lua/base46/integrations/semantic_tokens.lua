local theme = require("base46").current_theme
local base16 = require("base46").theme_tables[theme].base_16

return {
  ["@lsp.type.comment"] = { link = "Comment" },

  ["@lsp.type.operator"] = { fg = base16.base05 },
  ["@lsp.type.punctuation"] = { fg = base16.base05 },
  ["@lsp.type.variable"] = { fg = base16.base05 },
  ["@lsp.type.attributeBracket"] = { fg = base16.base05 },

  ["@lsp.type.macro"] = { fg = base16.base08 },
  ["@lsp.type.formatSpecifier"] = { fg = base16.base08 },
  ["@lsp.type.namespace"] = { fg = base16.base08 },
  ["@lsp.type.parameter"] = { fg = base16.base08 },
  ["@lsp.type.property"] = { fg = base16.base08 },
  ["@lsp.type.decorator"] = { fg = base16.base08 },
  ["@lsp.type.builtinAttribute"] = { fg = base16.base08 },
  ["@lsp.type.generic"] = { fg = base16.base08 },

  ["@lsp.type.boolean"] = { fg = base16.base09 },
  ["@lsp.type.enumMember"] = { fg = base16.base09 },
  ["@lsp.type.const"] = { fg = base16.base09 },
  ["@lsp.type.number"] = { fg = base16.base09 },
  ["@lsp.type.selfKeyword"] = { fg = base16.base09 },
  ["@lsp.type.selfTypeKeyword"] = { fg = base16.base09 },
  ["@lsp.typemod.enumMember.defaultLibrary"] = { fg = base16.base09 },
  ["@lsp.typemod.variable.defaultLibrary"] = { fg = base16.base09 },
  ["@lsp.typemod.variable.static"] = { fg = base16.base09 },

  ["@lsp.type.struct"] = { fg = base16.base0A, sp = "none" },
  ["@lsp.type.class"] = { fg = base16.base0A, sp = "none" },
  ["@lsp.type.builtinType"] = { fg = base16.base0A },
  ["@lsp.type.deriveHelper"] = { fg = base16.base0A },
  ["@lsp.type.enum"] = { fg = base16.base0A, sp = "none" },
  ["@lsp.type.interface"] = { fg = base16.base0A, sp = "none" },
  ["@lsp.type.typeAlias"] = { fg = base16.base0A },
  ["@lsp.typemod.class.defaultLibrary"] = { fg = base16.base0A },
  ["@lsp.typemod.enum.defaultLibrary"] = { fg = base16.base0A },
  ["@lsp.typemod.struct.defaultLibrary"] = { fg = base16.base0A },

  ["@lsp.type.string"] = { fg = base16.base0B },

  ["@lsp.type.escapeSequence"] = { fg = base16.base0C },
  ["@lsp.type.lifetime"] = { fg = base16.base0C },

  ["@lsp.type.function"] = { fg = base16.base0D },
  ["@lsp.type.method"] = { fg = base16.base0D },
  ["@lsp.typemod.function.defaultLibrary"] = { fg = base16.base0D },
  ["@lsp.typemod.macro.defaultLibrary"] = { fg = base16.base0D },
  ["@lsp.typemod.method.defaultLibrary"] = { fg = base16.base0D },
  ["@lsp.typemod.variable.callable"] = { fg = base16.base0D },

  ["@lsp.type.keyword"] = { fg = base16.base0E },
  ["@lsp.typemod.keyword.async"] = { fg = base16.base0E },
}
