config = {
	debugEnabled   = true  -- toggle debug console output
}

-- Colours for all objects: (rgb255 in table format: {red, green, blue [, alpha] } )
config.colour = {
	bird           = {204, 175, 061, 0},
	pipe           = {069, 150, 044, 1}, --{57, 187, 60, 1},

	sky            = {090, 160, 201},

	ground = {
		grass      = {044, 071, 037, 1},
		dirt       = {056, 042, 029, 1}
	}
}

-- All about the player:
config.player = {
	radius         = 25,         -- player collision radius (collider is a square tho, lol)
	jump           = 6.3,          -- jump force
	gravity        = 0.17,       -- gravity pull (pixels / frame)
	maxSpeed       = 9,          -- maximal movement speed (up and down)
	startSpeed     = 4,          -- initial "jump"

	coinGain       = 0.5,        -- coin/pipe

	-- Animation:
	defaultSkinID  = "default",  -- default skin
	flopRate       = 25          -- frames spent displaying jump sprite
}

-- All about Pipes:
config.pipe = {
	startGap       = width/3,     -- distance between player and first pipe at start
	amount         = 7,           -- amount of pipes that are calculated and rendered
	distance       = width*0.49,  -- distance between pipes
	width          = 65,          -- pipe width

	gap = {
		min        = 2 * config.player.radius * 3.8,  -- minimum and...
		max        = 2 * config.player.radius * 5.5   -- ... maximum size of the gap (where player flies through)
	},

	topPart = {
		width      = 7,   -- width and...
		height     = 25,  -- ... height of the pipe top part
		offset     = 7    -- y axis pixel offset (0 = no offset, <0 = "down", >0 = "up")
	},

	draw = {
		shade      = 0.7,  -- Shade beginning (range = 1 - 0 ; x -> 1 = less shadow ; x -> 0 = more shadow)
		shd_harsh  = 0.8,  -- Shadow Harshness (1 = no shadow, <1 = darker, >1 = lighter)
		topShade   = 1.06  -- Add additional shading onto top part
	}
}

-- Screen X-Axis Scroll:
config.scroll = {
	speed          = 1.45, -- initial scroll speed (pixels / frame)
	increment      = 0.01  -- scroll speed increase when passing a pipe
}

-- Everything Shop-related:
config.shop = {
	indent         = 5,   -- indentation to shop edge
	pageButton     = 50,  -- size of the page up/down button

	skinsPerPage   = 5,   -- amount of skins per page
	spacing        = 10,  -- space between skins to keep stuff looking clean

	animationSpeed = 60  -- how many frames to show a sprite-frame
}

-- Background Stuff:
config.background = {
	cloudSpeed   = -0.05  -- speed of cloud movement (without parallax)
}

-- Background Prallax values: (0 = static ; <0 = movement towards east ; >0 = movement towards west)
config.prallax = {
	clouds = 0.01,
	cities = 0.1
}


return config