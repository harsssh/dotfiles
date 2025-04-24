local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'Monaspace Argon'
config.color_scheme = 'GitHub Dark'

return config
