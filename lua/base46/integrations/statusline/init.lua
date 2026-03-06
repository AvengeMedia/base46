local stl_theme = require("base46").opts.nvchad.statusline_theme

if stl_theme == nil then
  return {}
end

local theme_module = "base46.integrations.statusline." .. stl_theme
return require(theme_module)
