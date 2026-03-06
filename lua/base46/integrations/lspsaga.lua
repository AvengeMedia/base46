local theme = require("base46").current_theme
local colors = require("base46").theme_tables[theme].base_30
local opts = require("base46").opts

if opts.transparency then
  return {}
end

return {
  SagaBorder = {
    bg = colors.darker_black,
  },
  SagaNormal = {
    bg = colors.darker_black,
  },
}
