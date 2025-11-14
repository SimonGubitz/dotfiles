--- === TrafficRacer ===

local obj = {}
obj.__index = obj

obj.name = "TrafficRacer"
obj.version = "1.0"

-- === CONFIG ===
local gasCoords = { x = 1190, y = 790 }
local brakeCoords = { x = 370, y = 790 }
local pauseCoords = { x = 1235, y = 180 }
local resumeCoords = { x = 770, y = 370 }
local newGameCoords = { x = 960, y = 820 }
local honkCoords = { x = 300, y = 560 }

local targetAppName = "Traffic Racer"

-- === HELPERS ===
local function isTrafficRacerActive()
	local app = hs.application.frontmostApplication()
	return app and app:name() == targetAppName
end

local function mouseDownAt(point)
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, point):post()
end

local function mouseUpAt(point)
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, point):post()
end

-- === INTERNAL STATE ===
local keyHeld = {}
local handler = nil

-- === START / STOP ===
function obj:start()
	if handler then
		return self
	end -- already running

	handler = hs.eventtap.new({
		hs.eventtap.event.types.keyDown,
		hs.eventtap.event.types.keyUp,
	}, function(event)
		local code = event:getKeyCode()
		local isDown = event:getType() == hs.eventtap.event.types.keyDown

		local key, coords = nil, nil

		if code == hs.keycodes.map["w"] then
			key, coords = "w", gasCoords
		elseif code == hs.keycodes.map["s"] then
			key, coords = "s", brakeCoords
		elseif code == hs.keycodes.map["h"] then
			key, coords = "h", honkCoords
		elseif code == hs.keycodes.map["escape"] then
			key, coords = "esc", pauseCoords
		elseif code == hs.keycodes.map["return"] then
			key, coords = "enter", resumeCoords
		elseif code == hs.keycodes.map["n"] then
			key, coords = "n", newGameCoords
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
	hs.alert.show("🚗 TrafficRacer controls enabled")
	return self
end

function obj:stop()
	if handler then
		handler:stop()
		handler = nil
		keyHeld = {}
		hs.alert.show("🛑 TrafficRacer controls disabled")
	end
	return self
end

-- Optional: toggle control (useful for pausing)
function obj:toggle()
	if handler then
		self:stop()
	else
		self:start()
	end
end

return obj
