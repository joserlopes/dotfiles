local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("0xProto")
config.font_size = 16
config.color_scheme = "Everforest Dark (Gogh)"
config.window_background_opacity = 0.8

return config
