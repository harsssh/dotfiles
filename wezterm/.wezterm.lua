local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'Monaspace Argon'
config.color_scheme = 'GitHub Dark'

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_ime = true

-- デフォルトは option + enter
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
