local path = "assets/sound/"
local function load(file, type)
	return love.audio.newSource(path .. file, type)
end

sound = {
	ui = {
		page = {
			up   = load("ui/pageUP.wav", "static"),      -- Credit: "Cleyton Kauffman - https://soundcloud.com/cleytonkauffman" ( CC BY-SA 4.0 )
			down = load("ui/pageDOWN.wav", "static")     -- Credit: "Cleyton Kauffman - https://soundcloud.com/cleytonkauffman" ( CC BY-SA 4.0 )
		},
		select = {
			yes  = load("ui/select_yes.wav", "static"),  -- Credit: "Jesús Lastra" ( CC-BY 3.0 )
			no   = load("ui/select_no.wav", "static")    -- Credit: "Jesús Lastra" ( CC-BY 3.0 )
		},
		equip = {
			load("ui/equip1.wav", "static"),             -- Credit: "artisticdude" ( GPL 3.0 )
			load("ui/equip2.wav", "static")              -- Credit: "artisticdude" ( GPL 3.0 )
		},
		buy = load("ui/buy.wav", "static")               -- Credit: "artisticdude" ( GPL 3.0 )
	},

	player = {
		score = {
			load("player/yay1.wav",  "static")--[[,
			load("player/yay2.wav",  "static"),
			load("player/yay3.wav",  "static")]]
		},
		jump = {
			load("player/Jump1.wav", "static")--[[,
			load("player/Jump2.wav", "static"),
			load("player/Jump3.wav", "static"),
			load("player/Jump4.wav", "static")]]
		},
		hurt = {
			load("player/hurt.wav", "static")
		}
	}
}

return sound