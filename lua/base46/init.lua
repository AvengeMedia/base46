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
  -- integration with DankMaterialShell
  _DMS_SUPPORT = true,

  opts = {
    -- Each theme has a `type` field set to dark or light.
    -- If this is true, vim.o.background will be updated accordingly when a theme is loaded.
    set_background = true,
    -- If this is true, the 16 colors of neovim's terminal will be set accordingly when a theme is loaded.
    term_colors = true,
    -- Enable transparent background.
    transparency = false,

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
      alpha = true,
      avante = true,
      ["blink-pair"] = true,
      bufferline = true,
      codeactionmenu = true,
      dap = true,
      diffview = true,
      edgy = true,
      flash = true,
      ["git-conflict"] = true,
      grug_far = true,
      hop = true,
      leap = true,
      lspsaga = true,
      markview = true,
      ["mini-tabline"] = true,
      navic = true,
      neogit = true,
      notify = true,
      nvshades = true,
      orgmode = true,
      rainbowdelimiters = true,
      ["render-markdown"] = true,
      semantic_tokens = true,
      ["tiny-inline-diagnostic"] = true,
      todo = true,
      trouble = true,
      ["vim-illuminate"] = true,
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
      statusline_theme = "default",
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

M.merge_tb = function(...)
  return vim.tbl_deep_extend("force", ...)
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
  highlights = vim.tbl_deep_extend("force", highlights, hl_override)
  highlights = M.turn_str_to_color(highlights)

  return highlights
end

---@param name string
---@return table?
M.get_integration = function(name)
  if name == "statusline" and M.opts.nvchad.statusline_theme then
    package.loaded["base46.integrations.statusline." .. M.opts.nvchad.statusline_theme] = nil
  end
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

---@param theme string
---@return Base46Table?
M.get_builtin_theme = function(theme)
  local present, base46table = pcall(require, "base46.themes." .. theme)
  if present then
    return base46table
  end
end

---@param t table
---@param f fun(_): any
local function tbl_deep_map_inplace(t, f)
  for k, v in pairs(t) do
    if type(v) == "table" then
      tbl_deep_map_inplace(v, f)
    else
      t[k] = f(v)
    end
  end
end

---WARN: `design_table` is modified in place.
---
---Creates new base46 palette from a `design_table` by changing the colors
---related to background of the UI, targetting `bg_color` as a global background.
---Does nothing if `bg_color` is an invalid hex string.
---@param design_table Base46Table Original table
---@param bg_color string Hex string
---@return Base46Table
M.theme_set_bg = function(design_table, bg_color)
  local r, g, b = require("base46.colors").hex2rgb(bg_color)
  if not r or not g or not b then
    return design_table
  end
  local lighten_dir
  if design_table.type == "light" then
    lighten_dir = -1
  else
    lighten_dir = 1
  end
  -- shorthand
  local b30 = design_table.base_30
  -- the operations here just follow siduck's heuristic recommandation
  b30.black = bg_color
  b30.darker_black = assert(lighten(b30.black, lighten_dir * -6))
  b30.black2 = assert(lighten(b30.black, lighten_dir * 6))
  b30.one_bg = assert(lighten(b30.black, lighten_dir * 10))
  b30.one_bg2 = assert(lighten(b30.one_bg, lighten_dir * 6))
  b30.one_bg3 = assert(lighten(b30.one_bg2, lighten_dir * 6))

  design_table.base_16.base00 = bg_color

  return design_table
end

---WARN: `design_table` is modified in place.
---
---Creates new base46 palette from a `design_table` by shifting the hues of its colors towards
---that of `source_color`. Does nothing if `source_color` is an invalid hex string, or if either
---`harmony` or `threshold` are outside valid ranges.
---@param design_table Base46Table Original table
---@param source_color string Hex string
---@param harmony number? (0-1, default: 0.5) How much the colors must be shifted towards `source_color`.
---@param threshold number? (0-180, default: 100) Maximum authorized hue shift, in degrees
---@return Base46Table
M.theme_harmonize = function(design_table, source_color, harmony, threshold)
  if harmony == nil then
    harmony = 0.5
  end
  if threshold == nil then
    threshold = 100
  end

  local r, g, b = require("base46.colors").hex2rgb(source_color)
  if not r or not g or not b or harmony < 0 or harmony > 1 or threshold < 0 or threshold > 180 then
    return design_table
  end
  tbl_deep_map_inplace(design_table, function(value)
    if type(value) ~= "string" then
      return value
    end
    local new_hue = require("base46.colors").harmonize(value, source_color, harmony, threshold)
    if new_hue ~= nil then
      return new_hue
    else
      return value
    end
  end)
  return design_table
end

M.load = function(theme)
  if not M.theme_tables[theme] then
    local base46table = M.get_builtin_theme(theme)
    if base46table then
      M.theme_tables[theme] = base46table
    else
      return vim.notify("Theme '" .. theme .. "' not found", vim.lsp.log.ERROR, { title = "base46" })
    end
  end

  M.current_theme = theme
  vim.cmd("hi clear")
  if M.opts.set_background ~= false then
    vim.o.bg = M.theme_tables[theme].type
  end
  vim.g.colors_name = "base46-" .. theme

  for name, enabled in pairs(M.opts.integrations) do
    if enabled then
      for hlname, hlopts in pairs(M.get_integration(name) or {}) do
        vim.api.nvim_set_hl(0, hlname, hlopts)
      end
    end
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

M.load_all_highlights = function()
  if M.current_theme then
    M.load(M.current_theme)
  end
  vim.api.nvim_exec_autocmds("User", { pattern = "NvThemeReload" })
end

return M
