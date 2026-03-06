---@class Base46Table
---@field base_16 Base16Table
---@field base_30 Base30Table
---@field type "dark"|"light"
---@field polish_hl table? Overrides for integration highlights

---@class Base16Table
---@field base00 string
---@field base01 string
---@field base02 string
---@field base03 string
---@field base04 string
---@field base05 string
---@field base06 string
---@field base07 string
---@field base08 string
---@field base09 string
---@field base0A string
---@field base0B string
---@field base0C string
---@field base0D string
---@field base0E string
---@field base0F string

---@class Base30Table
---@field white string
---@field darker_black string
---@field black string
---@field black2 string
---@field one_bg string
---@field one_bg2 string
---@field one_bg3 string
---@field grey string
---@field grey_fg string
---@field grey_fg2 string
---@field light_grey string
---@field red string
---@field baby_pink string
---@field pink string
---@field line string
---@field green string
---@field vibrant_green string
---@field blue string
---@field nord_blue string
---@field yellow string
---@field sun string
---@field purple string
---@field dark_purple string
---@field teal string
---@field orange string
---@field cyan string
---@field statusline_bg string
---@field lightbg string
---@field pmenu_bg string
---@field folder_bg string

local M = {
  opts = {
    -- Each theme has a `type` field set to dark or light.
    -- If this is true, vim.o.background will be updated accordingly when a theme is loaded.
    set_background = true,
    -- If this is true, the 16 colors of neovim's terminal will be set accordingly when a theme is loaded.
    term_colors = true,
    -- Enable transparent background.
    transparency = false,

    -- Corresponds to nvchad's defaults
    integrations = {
      blankline = true,
      blink = true,
      cmp = true,
      defaults = true,
      devicons = true,
      git = true,
      lsp = true,
      mason = true,
      nvcheatsheet = true,
      nvimtree = true,
      statusline = true,
      syntax = true,
      treesitter = true,
      tbline = true,
      telescope = true,
      whichkey = true,

      alpha = false,
      avante = false,
      ["blink-pair"] = false,
      bufferline = false,
      codeactionmenu = false,
      dap = false,
      diffview = false,
      edgy = false,
      flash = false,
      ["git-conflict"] = false,
      grug_far = false,
      hop = false,
      leap = false,
      lspsaga = false,
      markview = false,
      ["mini-tabline"] = false,
      navic = false,
      neogit = false,
      notify = false,
      nvshades = false,
      orgmode = false,
      rainbowdelimiters = false,
      ["render-markdown"] = false,
      semantic_tokens = false,
      ["tiny-inline-diagnostic"] = false,
      todo = false,
      trouble = false,
      ["vim-illuminate"] = false,
    },

    -- Some other nvchad config parameters used in the plugin. I imagine you
    -- The plugin will not be able to sync them with nvchad itself, but I
    -- imagine this should not be an issue, since you would not use this
    -- plugin if you were using nvchad.
    nvchad = {
      ---@type "default"|"atom"|"atom_colored"|"flat_light"|"flat_dark"
      cmp_style = "default",
      ---@type "bordered"|"borderless"
      telescope_style = "bordered",
      ---Set to nil when nvchad's statusline is disabled
      ---@type "default"|"minimal"|"vscode"|"vscode_colored"|nil
      statusline_theme = nil,
      -- Some highlights change on the cheatsheet if it is set to "grid"
      cheatsheet_theme = nil,
    },
  },
}

---@type table<string, Base46Table>
M.theme_tables = {}

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

local lighten = require("base46.colors").change_hex_lightness
local mixcolors = require("base46.colors").mix

---Turns color var names in hl_override/hl_add to actual colors
---Example: hl_add = { abc = { bg = "one_bg" }} -> bg = colors.one_bg
M.turn_str_to_color = function(tb)
  local colors = vim.tbl_extend(
    "force",
    M.theme_tables[M.current_theme].base_30 or {},
    M.theme_tables[M.current_theme].base_16 or {}
  )
  local copy = vim.deepcopy(tb)

  for _, hlgroups in pairs(copy) do
    for opt, val in pairs(hlgroups) do
      local valtype = type(val)
      if opt == "fg" or opt == "bg" or opt == "sp" then
        -- named colors from base30
        if valtype == "string" and colors[val] ~= nil then
          hlgroups[opt] = colors[val]
        elseif valtype == "table" and colors[val[1]] ~= nil then
          -- transform table to color
          if #val == 2 then
            hlgroups[opt] = lighten(colors[val[1]], val[2])
          elseif #val == 3 and colors[val[2]] ~= nil then
            hlgroups[opt] = mixcolors(colors[val[1]], colors[val[2]], val[3])
          end
        end
      end
    end
  end

  return copy
end

---@param highlights table
---@param integration_name string
---@return table highlights
M.extend_default_hl = function(highlights, integration_name)
  local polish_hl = M.theme_tables[M.current_theme].polish_hl

  -- polish themes
  highlights = vim.tbl_deep_extend("force", highlights, polish_hl and polish_hl[integration_name] or {})

  -- transparency
  if M.opts.transparency then
    local glassy = require("base46.glassy")
    highlights = vim.tbl_deep_extend("force", highlights, glassy(M.current_theme))
  end

  local hl_override = M.opts.hl_override or {}
  local overriden_hl = M.turn_str_to_color(hl_override)
  highlights = vim.tbl_deep_extend("force", highlights, overriden_hl)

  return highlights
end

---@param name string
---@return table?
M.get_integration = function(name)
  package.loaded["base46.integrations." .. name] = nil
  local present, highlights = pcall(require, "base46.integrations." .. name)
  if not present then
    vim.notify("Integration '" .. name .. "' not found", vim.log.levels.ERROR, { title = "base46" })
  else
    return M.extend_default_hl(highlights, name)
  end
end

local term = {
  "base01",
  "base08",
  "base0B",
  "base0A",
  "base0D",
  "base0E",
  "base0C",
  "base05",
  "base03",
  "base08",
  "base0B",
  "base0A",
  "base0D",
  "base0E",
  "base0C",
  "base07",
}

M.load = function(theme)
  if not M.theme_tables[theme] then
    local present, base46table = pcall(require, "base46.themes." .. theme)
    if present then
      M.theme_tables[theme] = base46table
    else
      vim.notify("Theme '" .. theme .. "' not found", vim.lsp.log.ERROR, { title = "base46" })
    end
  end

  M.current_theme = theme
  vim.cmd("hi clear")

  for name, enabled in pairs(M.opts.integrations) do
    if enabled then
      for hlname, hlopts in pairs(M.get_integration(name) or {}) do
        vim.api.nvim_set_hl(0, hlname, hlopts)
      end
    end
  end

  if M.opts.set_background ~= false then
    vim.o.bg = M.theme_tables[theme].type
  end

  if M.opts.term_colors ~= false then
    local colors = M.theme_tables[theme].base_16
    for i = 0, 15 do
      vim.g["terminal_color_" .. tostring(i)] = colors[term[i + 1]]
    end
  end

  -- update blankline
  if package.loaded["ibl"] then
    require("ibl").update()
  end
end

M.override_theme = function(default_theme, theme_name)
  local changed_themes = M.opts.changed_themes or {}
  return vim.tbl_deep_extend("force", default_theme, changed_themes.all or {}, changed_themes[theme_name] or {})
end

return M
