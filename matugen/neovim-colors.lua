-- Change the NvChad base themes you want to use and
-- the harmonies with matugen colors here
local bases = {
  dark = "github_dark",
  light = "github_light",
}
local harmonies = {
  dark = 0.5,
  light = 0.5,
}

local theme_name = "base46-matugen"

local present, base46 = pcall(require, "base46")
if not present or not base46._DMS_SUPPORT then
  vim.notify(
    "base46 plugin not found or incorrect, make sure to install AvengeMedia/base46",
    vim.log.levels.ERROR,
    { title = theme_name }
  )
  return
end

local current_file_path = debug.getinfo(1, "S").source:sub(2)
local theme_base = bases[vim.o.background]
local harmony = harmonies[vim.o.background]

if not _G._matugen_theme_watcher then
  local uv = vim.uv or vim.loop
  _G._matugen_theme_watcher = { uv.new_fs_event(), reload_timer = uv.new_timer() }

  local debounce_time = 100 -- ms
  local function handler()
    _G._matugen_theme_watcher.reload_timer:stop()
    _G._matugen_theme_watcher.reload_timer:start(
      debounce_time,
      0,
      vim.schedule_wrap(function()
        base46.theme_tables[theme_name] = nil
        if vim.g.colors_name == theme_name then
          vim.cmd.colorscheme(theme_name)
          vim.notify("Theme reload", vim.log.levels.INFO, { title = theme_name })
        end
        -- NOTE: contrary to what the documentation says, uv fs events usually do not manage to react to more than one edit.
        -- I understand that this is not intended: some edit processes in a typical system (e.g. the one neovim uses with
        -- multiple renames and changes) make things hard to follow for libuv. Therefore, a restart is the best option.
        _G._matugen_theme_watcher[1]:stop()
        _G._matugen_theme_watcher[1]:start(current_file_path, {}, handler)
      end)
    )
  end
  _G._matugen_theme_watcher[1]:start(current_file_path, {}, handler)
end

if not base46.theme_tables[theme_name] or base46.theme_tables[theme_name].type ~= vim.o.background then
  local builtin = vim.deepcopy(assert(base46.get_builtin_theme(theme_base)))
  local harmonized = base46.theme_harmonize(builtin, "{{colors.source_color.default.hex}}", harmony)
  harmonized = base46.theme_set_bg(harmonized, "{{colors.background.default.hex}}")

  base46.theme_tables[theme_name] = harmonized
end

base46.load(theme_name)
vim.g.colors_name = theme_name
