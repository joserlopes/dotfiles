local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("0xProto", { weight = "Regular" })
config.font_size = 16
config.color_scheme = "Black Metal (Gorgoroth) (base16)"
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"

config.keys = {
	{
		key = "F11",
		action = wezterm.action.ToggleFullScreen,
	},
}

config.webgpu_preferred_adapter = {
	backend = "Vulkan",
	device = 9632,
	device_type = "DiscreteGpu",
	driver = "NVIDIA",
	driver_info = "560.35.03",
	name = "NVIDIA GeForce RTX 3050 Ti Laptop GPU",
	vendor = 4318,
}
config.front_end = "WebGpu"

return config
