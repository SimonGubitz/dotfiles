local mainMod = "SUPER"
local secondMod = "ALT"

local terminal = "kitty"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + tab", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.window.cycle_next({ next = prev }))

-- Spotlight
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_raw("tofi-drun | xargs -r hyprctl eval 'hl.dsp.exec( - )'"))

-- Window Movement / Sizing
hl.bind("CTRL + " .. mainMod .. " + F", hl.dsp.window.fullscreen({
	mode = "fullscreen",
	action = toggle
}
))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + " .. secondMod .. " + escape",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + " .. secondMod .. " + Q", hl.dsp.exec_cmd("hyprlock --immediate-render"))

for i = 1, 10 do
	local key = (i % 10)
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


-- Multi-Media
local media_playpause = "playerctl play-pause"
local media_previous = "playerctl previous"
local media_next = "playerctl next"
local media_mute = "pactl set-sink-mute 0 toggle"
local media_decrease_vol = "sh -c \"pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -5%\""
local media_increase_vol = "sh -c \"pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%\""

hl.bind("F7", hl.dsp.exec_cmd(media_previous))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(media_previous))
hl.bind("F9", hl.dsp.exec_cmd(media_next))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(media_next))

hl.bind("F8", hl.dsp.exec_cmd(media_playpause))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play"))

-- hl.bind("F10", hl.dsp.exec_cmd(media_mute))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(media_mute))

hl.bind("F11", hl.dsp.exec_cmd(media_decrease_vol))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(media_decrease_vol))

hl.bind("F12", hl.dsp.exec_cmd(media_increase_vol))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(media_increase_vol))
