local path = "assets/img/"
local function load(file)
	return love.graphics.newImage(path .. file)
end

image = {}

image.icon = load("icon.png")

path = "assets/img/skins/"
image.skin = {
	default = load("default.png"),
	duckjpg = load("duck.jpg")
}

return image