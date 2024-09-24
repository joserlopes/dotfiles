local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.font = wezterm.font("0xProto", { weight = "Regular" })
config.font_size = 16
config.color_scheme = "Black Metal (Gorgoroth) (base16)"
config.window_background_opacity = 1
config.enable_tab_bar = false

return config
