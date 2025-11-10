local gasCoords = { x = 1190, y = 790 }
local brakeCoords = { x = 370, y = 790 }
local pauseCoords = { x = 1235, y = 180 }
local resumeCoords = { x = 770, y = 370 }
local newGameCoords = { x = 960, y = 820 }
local honkCoords = { x = 300, y = 560 }

local targetAppName = "Traffic Racer"

-- === HELPER FUNCTIONS ===

-- Check if Traffic Racer is active
local function isTrafficRacerActive()
	local app = hs.application.frontmostApplication()
	return app and app:name() == targetAppName
end

-- Press and release mouse helpers
local function mouseDownAt(point)
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, point):post()
end

local function mouseUpAt(point)
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, point):post()
end

-- Track held state so we don’t send duplicate downs/ups
local keyHeld = {
	w = false,
	s = false,
}

-- === EVENT HANDLER ===
local handler = hs.eventtap.new({
	hs.eventtap.event.types.keyDown,
	hs.eventtap.event.types.keyUp,
}, function(event)
	local code = event:getKeyCode()
	local isDown = event:getType() == hs.eventtap.event.types.keyDown

	local key = nil
	local coords = nil

	if code == hs.keycodes.map["w"] then
		key = "w"
		coords = gasCoords
	elseif code == hs.keycodes.map["s"] then
		key = "s"
		coords = brakeCoords
	elseif code == hs.keycodes.map["n"] then
		key = "n"
		coords = newGameCoords
	elseif code == hs.keycodes.map["h"] then
		key = "h"
		coords = honkCoords
	elseif code == hs.keycodes.map["escape"] then
		key = "esc"
		coords = pauseCoords
	elseif code == hs.keycodes.map["return"] then
		key = "enter"
		coords = resumeCoords
	end

	if key and isTrafficRacerActive() then
		if isDown and not keyHeld[key] then
			mouseDownAt(coords)
			keyHeld[key] = true
		elseif (not isDown) and keyHeld[key] then
			mouseUpAt(coords)
			keyHeld[key] = false
		end
		return true -- block normal key behavior
	end
end)

handler:start()

-- Optional: notify on load
hs.alert.show("Traffic Racer hold controls active")
