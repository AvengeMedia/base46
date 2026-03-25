⚠️ For DMS users, please have a look at [DMS integration](#dms-integration).

## NvChad-independent version of its theme plugin

- This plugin should provide the same themes as those present in NvChad, without requiring either NvChad or `nvconfig` to be configured.
- Themes behave more like "regular" themes, and can be enabled with a `colorscheme` command.
- A few things work differently internally. This should not change much the user experience, though.

## Setup

Install with your favourite plugin manager, and call `require("base46").setup` with your preferred options. Example with `lazy.nvim`:
```lua
{
  "AvengeMedia/base46",
  lazy = true,
  opts = {},
}
```
You can set `lazy = true`, as `lazy.nvim` will load the plugin automatically if you decide to load one of its colorschemes.

## Loading a colorscheme

As simple as
```lua
-- Lua
vim.cmd.colorscheme("base46-gruvchad")
```
```vim
" Vim
colorscheme base46-chadracula-evondev
```

## Supported Integrations

- Bufferline.nvim
- Cmp.nvim
- Codeactionmenu
- Nvim-dap
- Nvim-webdevicons
- Hop.nvim
- Vim-illuminate
- LSP (diagnostics)
- Lualine
- Nvim Navic
- LspSaga
- Mason.nvim
- Notify.nvim
- Nvim-tree
- Telescope.nvim
- Rainbow-delimiters.nvim
- Todo.nvim
- Nvim-treesitter
- Lsp Semantic tokens
- Trouble.nvim
- Whichkey.nvim
- git-conflict.nvim
- Orgmode
- diffview.nvim
- leap.nvim
- Edgy.nvim
- Grug-far.nvim
- Flash.nvim
- Blink.nvim
- Blink.pairs

## Configuration

Here is the default configuration, which already contains most available options:
```lua
{
  -- Each theme has a `type` field set to dark or light.
  -- If this is true, vim.o.background will be updated accordingly when a theme is loaded.
  set_background = true,
  -- If this is true, the 16 colors of neovim's terminal will be set accordingly when a theme is loaded.
  term_colors = true,
  -- Enable transparent background.
  transparency = false,

  -- Contrary to NvChad, all integrations are enabled by default.
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
}
```

Other than that, you should be able to use the options `hl_override` and `changed_themes` just like NvChad's version would expect you to, although I have not tested these options. These are documented [here](https://github.com/NvChad/ui/blob/v3.0/doc/nvui.txt).

## Creating your own theme

The most natural way, in Neovim, to create your own colorscheme, is to create a lua file with your scheme's name under `colors/` in your config directory. Typically, in `~/.config/nvim/colors/foo.lua` on Linux. Then, you just write a lua script to be executed when `colorscheme foo` is called. Below is how such a file can look like to create a custom theme with base46. For complete examples of these theme tables, you can look at [NvChad's builtins](https://nvchad.com/themes) (look at the file names [here](https://github.com/NvChad/base46/tree/v3.0/lua/base46/themes) to know the exact name of the theme).

Some colors are found by lightening or darkening others down. To this end, you can use a color lightening/darkening tool, such as [this one](https://imagecolorpicker.com/color-code).

**Note: the below values are mostly approx values so its not compulsory that you
have to use those exact numbers.**

```lua
---colors/foo.lua
-- All colors are expected to be hexadecimal strings.

---@type Base46Table
local theme_table = {
  -- UI, mandatory
  base_30 = {
    white = "",
    black = "", -- usually your theme bg
    darker_black = "", -- 6% darker than black
    black2 = "", -- 6% lighter than black
    one_bg = "", -- 10% lighter than black
    one_bg2 = "", -- 6% lighter than one_bg
    one_bg3 = "", -- 6% lighter than one_bg2
    grey = "", -- 40% lighter than black (the % here depends so choose the perfect grey!)
    grey_fg = "", -- 10% lighter than grey
    grey_fg2 = "", -- 5% lighter than grey
    light_grey = "",
    red = "",
    baby_pink = "",
    pink = "",
    line = "", -- 15% lighter than black
    green = "",
    vibrant_green = "",
    nord_blue = "",
    blue = "",
    yellow = "",
    sun = "",  -- 8% lighter than yellow
    purple = "",
    dark_purple = "",
    teal = "",
    orange = "",
    cyan = "",
    statusline_bg = "",
    lightbg = "",
    pmenu_bg = "",
    folder_bg = ""
  },

  -- Syntax highlighting, mandatory. Check https://github.com/chriskempson/base16/blob/master/styling.md for more info
  base_16 = {
    base00 = "",
    base01 = "",
    base02 = "",
    base03 = "",
    base04 = "",
    base05 = "",
    base06 = "",
    base07 = "",
    base08 = "",
    base09 = "",
    base0A = "",
    base0B = "",
    base0C = "",
    base0D = "",
    base0E = "",
    base0F = ""
  },

  -- Override some integrations' highlights for this specific theme only, optional.
  polish_hl = {
    defaults = {
      Comment = {
        bg = "#ffffff",
        italic = true,
      },
    },

    treesitter = {
      ["@variable"] = { fg = "#000000" },
    },
  },

  -- Set the theme type whether is dark or light, mandatory
  type = "dark", -- or "light"
}

-- Choose any name you want, it does not even have to be the name of the file, although it would be better.
require("base46").theme_tables["foo"] = theme_table
require("base46").load("foo")
```

## Quickly generate a theme based on a builtin one

This plugin was created for integration with [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell), which generates its UI from a single primary color. Following the example below, you can take any of the builtin themes and shift the hues of its colors towards that of a primary color, and get a new theme that will better align with your shell's UI. Here, we take `"nord"` as a base, shift it towards the pure red color `"#ff0000"` and set its background to a warm black `"#120e03"`.

```lua
---colors/nord-red.lua
local base46 = require("base46")
local theme_name = "nord-red"

-- avoid generating the theme twice in the same session
if not base46.theme_tables[theme_name] then
  -- be careful: the functions used to get a theme table and modify 
  -- it act on it in-place, without making copies.
  local builtin_nord = vim.deepcopy(assert(base46.get_builtin_theme("nord")))
  -- some other options are available to choose how much you want to harmonize nord towards red
  local nord_red = base46.theme_harmonize(builtin_nord, "#ff0000")
  nord_red = base46.theme_set_bg(nord_red, "#120e03")

  base46.theme_tables[theme_name] = nord_red
end

base46.load(theme_name)
```

### Lualine integration

Lualine requires a specific file to be supported. Taking back the example of `nord-red`, you can achieve lualine support with the following file in your neovim config:
```lua
---lua/lualine/themes/nord-red.lua
return require("lualine.themes._base46")("nord-red")
```

## DMS integration

https://github.com/user-attachments/assets/c050ff11-0a4a-47ce-85f8-a598854e8c2c

On top of the many builtin themes of this plugin, [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) users have access to a matugen template that generates a colorscheme `dms` that is automatically updated with their DMS theme. You can choose the base schemes for dark and light mode, as well as the "harmony" for each (i.e. the amount by which the original themes is tinted towards the DMS theme source color).

After enabling the integration in the settings and running DMS matugen templates, you can just open neovim and run
```vim
colorscheme dms
```
The theme should hotreload automatically (e.g. when your wallpaper change, the source color of your DMS theme changes or when you switch light/dark mode). Please open an issue in case this does not work.

## Credits

- [@siduck](https://github.com/siduck) for basically making this plugin alongside NvChad and developing most of its beautiful themes.
- [@LeonHeidelbach](https://github.com/LeonHeidelbach) for making [color functions!](https://github.com/LeonHeidelbach/lua_color_tools) which we use in base46.
