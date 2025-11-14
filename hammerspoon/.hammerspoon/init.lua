local TrafficRacer = hs.loadSpoon("TrafficRacer")

-- Start automatically:
TrafficRacer:start()

-- OR bind a toggle hotkey (recommended):
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "T", function()
	TrafficRacer:toggle()
end)
