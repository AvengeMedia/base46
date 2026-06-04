local theme = require("base46").current_theme
local base16 = require("base46").theme_tables[theme].base_16

return {
  SnacksDashboardKey = { fg = base16.base09 },
  SnacksDashboardTitle = { fg = base16.base0D },
  SnacksDashboardHeader = { fg = base16.base0D },
  SnacksDashboardIcon = { fg = base16.base08 },
  SnacksDashboardDesc = { fg = base16.base0B },
  SnacksDashboardFile = { fg = base16.base0B },
  SnacksDashboardFooter = { fg = base16.base0B, italic = true },
  SnacksDashboardSpecial = { fg = base16.base0E, bold = true },
}
