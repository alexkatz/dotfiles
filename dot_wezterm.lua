local wezterm = require("wezterm")

local RATIO = 0.92

local config = wezterm.config_builder()

local position_window = function(opts)
	opts.window:set_inner_size(
		opts.active_screen.width * opts.screen_ratio,
		opts.active_screen.height * opts.screen_ratio
	)

	opts.window:set_position(
		opts.active_screen.width * (1 - opts.screen_ratio) / 2,
		opts.active_screen.height * (1 - opts.screen_ratio) / 2
	)
end

wezterm.on("gui-startup", function(cmd)
	local active_screen = wezterm.gui.screens().active
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	position_window({ active_screen = active_screen, screen_ratio = RATIO, window = window:gui_window() })
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

config.keys = {
	{
		key = "f",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(win)
			local active_screen = wezterm.gui.screens().active
			if win:get_dimensions().is_full_screen then
				win:toggle_fullscreen()
			end

			position_window({ active_screen = active_screen, screen_ratio = RATIO, window = win })
		end),
	},
}

return config
