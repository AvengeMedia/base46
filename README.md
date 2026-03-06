## NvChad-independant version of its theme plugin

- This plugin should provide the same themes as those present in NvChad, without requiring either NvChad or `nvconfig` to be configured.
- Themes behave more like "regular" themes, and can be enabled with a `colorscheme` command.
- A few things work differently internally, as I have aligned the code style to my own preference. This should not change much the user experience, though.

## Setup

Install with your favourite plugin manager, and call `require("base46").setup` with your preferred options. Example with `lazy.nvim`:
```lua
{
  "Silzinc/base46.nvim",
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
}
```

Other than that, you should be able to use the options `hl_override` and `changed_themes` just like NvChad's version would expect you to, although I have not tested these options. These are apparently documented [here](https://github.com/NvChad/ui/blob/v3.0/doc/nvui.txt), but I have not read this in depth since I never planned on using these parameters myself.

## Creating your own theme

The most natural way, in Neovim, to create your own colorscheme, is to create a lua file with your scheme's name under `colors/` in your config directory. Typically, in `~/.config/nvim/colors/foo.lua` on Linux. Then, you just write a lua script to be executed when `colorscheme foo` is called. Below is how such a file can look like to create a custom theme with base46. For complete examples of these theme tables, you can look at [NvChad's builtins](https://github.com/NvChad/base46/tree/v3.0/lua/base46/themes).

Some colors are found by lightening or darkening others down. To this end, you can use a color lightening/darkening tool, such as [this one](https://imagecolorpicker.com/color-code).

**Note: the below values are mostly approx values so its not compulsory that you
have to use those exact numbers.**

```lua
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
    seablue = "",
    yellow = "", -- 8% lighter than yellow
    sun = "",
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
        bg = "#ffffff", -- or M.base_30.cyan
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

## Credits

- [@siduck](https://github.com/siduck) for basically making this plugin alongside NvChad and developing most of its beautiful themes.
- [@LeonHeidelbach](https://github.com/LeonHeidelbach) for making [color functions!](https://github.com/LeonHeidelbach/lua_color_tools) which we use in base46.
