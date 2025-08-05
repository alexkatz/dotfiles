local wezterm = require("wezterm")

local RATIO = 0.924

local config = wezterm.config_builder()

-- Position the window in the center of the screen
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

-- wezterm pane navigation
local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

config.audible_bell = "Disabled"
config.default_cursor_style = "SteadyBar"
config.color_scheme = "Catppuccin Macchiato"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20
config.adjust_window_size_when_changing_font_size = false

config.animation_fps = 165
config.max_fps = 165

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" })
config.font_size = 14.0

config.underline_position = -5
config.underline_thickness = 1

config.disable_default_key_bindings = true

config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 1000 }

config.keys = {
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),

	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),

	-- revert to default window size/ratio based on current screen size
	{
		key = "f",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(win)
			local active_screen = wezterm.gui.screens().active
			local win_dims = win:get_dimensions()
			if win_dims.is_full_screen then
				win:toggle_fullscreen()
			end

			position_window({ active_screen = active_screen, screen_ratio = RATIO, window = win })
		end),
	},

	-- paste
	{
		key = "v",
		mods = "CMD",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},

	-- toggle full screen
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},

	-- command palette
	{
		key = "p",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	},

	-- debug overlay
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.ShowDebugOverlay,
	},

	-- vertical split
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},

	-- horizontal split
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},

	-- zoom pane
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "/",
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- close pane
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
	},

	-- new tab
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
	},

	-- close tab
	{
		key = "q",
		mods = "LEADER",
		action = wezterm.action({ CloseCurrentTab = { confirm = true } }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
	},

	-- next tab
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action({ ActivateTabRelative = 1 }),
	},

	-- prev tab
	{
		key = "Tab",
		mods = "SHIFT|CTRL",
		action = wezterm.action({ ActivateTabRelative = -1 }),
	},

	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- copy mode
	{
		key = "Escape",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},

	-- search mode
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action.Search({ CaseInSensitiveString = "" }),
	},

	-- increase font size
	{ key = "+", mods = "CMD", action = wezterm.action.IncreaseFontSize },

	-- decrease font size
	{ key = "-", mods = "CMD", action = wezterm.action.DecreaseFontSize },
}

return config
