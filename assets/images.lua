local path = "assets/img/"
local function load(file)
	return love.graphics.newImage(path .. file)
end

image = {}

image.icon = load("icon.png")
image.coin = load("coin.png")
image.missing = load("missing.png")

path = "assets/img/background/"
image.background = {
	clouds = load("clouds.png"),
	sky    = load("sky.png"),
	cities = load("cities.png")
}

path = "assets/img/skins/"
image.skin = {
	default = load("default.png"),
	duckjpg = load("duck.jpg"),
	bopcat  = {
		idle = load("bopIDLE.jpg"),
		flop = load("bopFLOP.jpg")
	},
	pupsbird = {
		idle = load("pupsbirdIDLE.png"),
		flop = load("pupsbirdFLOP.png"),
		dead = load("pupsbirdDEAD.png")
	},
	air = {
		idle = load("airIDLE.png"),
		flop = load("airFLOP.png"),
		dead = load("airDEAD.png")
	}
}

return image