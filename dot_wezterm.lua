local wezterm = require("wezterm")

local config = wezterm.config_builder()

wezterm.on("gui-startup", function(cmd)
	local active_screen = wezterm.gui.screens().active
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	local SIZE = 0.9
	window:gui_window():set_inner_size(active_screen.width * SIZE, active_screen.height * SIZE)
	window:gui_window():set_position(active_screen.width * (1 - SIZE) / 2, active_screen.height * (1 - SIZE) / 2)
end)

config.audible_bell = "Disabled"

config.color_scheme = "Catppuccin Macchiato"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.80
config.macos_window_background_blur = 90
config.adjust_window_size_when_changing_font_size = false

config.font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" })
config.font_size = 14.0

config.underline_position = -5
config.underline_thickness = 1

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
