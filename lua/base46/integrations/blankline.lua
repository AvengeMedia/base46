local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30

local hl = {
  IblChar = { fg = colors.line },
  IblScopeChar = { fg = colors.grey },
}

local scopehl = require("base46").opts.transparency and { underline = true } or { bg = colors.black2 }

for i = 1, 7, 1 do
  hl["@ibl.scope.underline." .. i] = scopehl
end

return hl
