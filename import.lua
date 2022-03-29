local path = ""

-- FUNCTIONS:

-- Switches Path:
local function switch(newPath)
	path = newPath
	print("\n🔍 Loading in:     *" .. newPath .. "*")
end

-- Loads a module:
local modCount = 0
local function load(request)
	-- Module Path:
	local location = path .. "/" .. request
	local mod = require(location)

	-- Feedback Prinout:
	local out = "✅ Loaded Module:  " .. request
	-- Indentation:
	local gap = " "
	for i=#out, 35 do
		gap = gap .. " "
	end

	-- Return Module:
	print(out .. gap ..  "(" .. location .. ")")
	modCount = modCount + 1
	return mod
end


-- IMPORT: 

-- LIBRARIES:

-- Import Libraries:
switch("lib")
clr        = load("color")                -- Credit: https://github.com/randrews/color
Class      = load("class")                -- Credit: https://github.com/vrld/hump/
--Camera     = load("camera")               -- Credit: https://github.com/vrld/hump/


-- SOURCE:

-- Custom Libraries:
switch("src")
easy       = load("easy")
save       = load("save")

-- Import Classes:
switch("src/class")
load("Gui")
load("Button")

switch("src/class/Object")
load("Player")
load("Pipe")
load("Ground")
load("Background")

switch("src/class/Shop")
load("Shop")
load("Shopbutton")



-- DATA:

-- Game Data:
switch("data")
info       = load("info")
controls   = load("controls")
font       = load("font")
config     = load("config")
files      = load("files")

-- Assets:
switch("assets")
sound      = load("sounds")
image      = load("images")


-- End of Import:
print(clr.fg.YELLOW .. "\n" .. "☑️  Loaded Modules: " .. modCount .. clr.reset .. "\n")