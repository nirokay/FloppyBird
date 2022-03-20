config = {
	-- Toggle Deabug Console Output:
	debugEnabled = true,
}
	-- Colours for all objects: (rgb255 in table format)
config.colour = {
	bird = {204, 175, 61, 0.3},
	pipe = {57, 187, 60, 1},

	sky  = {90, 160, 201},

	ground = {
		grass = {44, 71, 37, 1},
		dirt = {56, 42, 29, 1}
	}
}

	-- All about the player:
config.player = {
	radius     = 25,
	jump       = 9,
	gravity    = 0.15,
	maxSpeed   = 7,
	startSpeed = 4
}

	-- All about Pipes:
config.pipe = {
	startGap   = width/3, --9*width/8,
	amount     = 5,
	distance   = width*0.45,
	width      = 45,

	gap = {
		min = 2 * config.player.radius * 4.2,
		max = 2 * config.player.radius * 6.5
	}
}

	-- Screen X-Axis Scroll:
config.scroll = {
	speed      = 1.5,
	increment  = 0.1
}


return config