return function(theme_name)
  local theme = assert(require("base46").get_builtin_theme(theme_name))
  local colors = theme.base_30
  return {
    normal = {
      a = { bg = colors.blue, fg = colors.black, gui = "bold" },
      b = { bg = colors.one_bg, fg = colors.blue },
      c = { bg = colors.statusline_bg, fg = colors.white },
    },

    insert = {
      a = { bg = colors.green, fg = colors.black, gui = "bold" },
      b = { bg = colors.one_bg, fg = colors.green },
    },

    command = {
      a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
      b = { bg = colors.one_bg, fg = colors.yellow },
    },

    visual = {
      a = { bg = colors.purple, fg = colors.black, gui = "bold" },
      b = { bg = colors.one_bg, fg = colors.purple },
    },

    replace = {
      a = { bg = colors.red, fg = colors.black, gui = "bold" },
      b = { bg = colors.one_bg, fg = colors.red },
    },

    terminal = {
      a = { bg = colors.green, fg = colors.black, gui = "bold" },
      b = { bg = colors.one_bg, fg = colors.green },
    },

    inactive = {
      a = { bg = colors.statusline_bg, fg = colors.blue, gui = "bold" },
      b = { bg = colors.statusline_bg, fg = colors.white },
      c = { bg = colors.statusline_bg, fg = colors.white },
    },
  }
end
