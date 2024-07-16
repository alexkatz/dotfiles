local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.audible_bell = "Disabled"

config.color_scheme = "Catppuccin Macchiato"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 90

config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })

config.underline_position = -5
config.underline_thickness = 1

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
