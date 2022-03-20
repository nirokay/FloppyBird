local path = "assets/sound/"
local function load(file, type)
	return love.audio.newSource(path .. file, type)
end

sound = {
	hurt = load("hurt.wav", "static"),
	jump = load("jump.wav", "static"),
	yay  = load("yay.wav",  "static")
}

return sound