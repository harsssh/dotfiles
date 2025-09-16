local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font("Monaspace Argon", { weight = "Regular" })
config.font_size = 14
config.color_scheme = "GitHub Dark"
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_ime = true
config.scrollback_lines = 100000

config.keys = {
  -- デフォルトは option + enter
  {
    key = "n",
    mods = "SHIFT|CTRL",
    action = act.ToggleFullScreen,
  },
  -- ⌘ + d で右方向にペイン分割
  { key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  -- ⌘ + Shift + d で下方向にペイン分割
  { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  -- ⌘ + w でペインを閉じる
  { key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
  -- ⌘ + [ / ] でペイン間の移動
  { key = "[", mods = "CMD", action = act.ActivatePaneDirection("Prev") },
  { key = "]", mods = "CMD", action = act.ActivatePaneDirection("Next") },
  -- ⌘ + Shift + [ / ] でタブ間の移動
  { key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
  { key = "K", mods = "CMD|SHIFT", action = act.ActivateCopyMode },
}

return config
