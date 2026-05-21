hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 18")

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 20,

		layout = "dwindle"
	},

	decoration = {
		rounding = 20,
		rounding_power = 4.0, -- squircle

		active_opacity = 1.0,
		inactive_opacity = 0.6,

		dim_inactive = 0,

		blur = {
			enabled = true,
			size = 5,
			passes = 1,
			vibrancy = 0.2,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		force_split = 2, -- split to the right
		preserve_split = true,
		split_width_multiplier = 1.6,
	},

	cursor = {
		hide_on_key_press = true,
	},
})
