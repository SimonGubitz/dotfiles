hl.curve("window-fade", { type = "bezier", points = { { 0.25, 1 }, { 0.25, 1 } } })


hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 9,
	bezier = "window-fade",
})
