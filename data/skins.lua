skins = {}

local function init(name, id, desc, price, imgs)
	local temp = {
		name  = name,
		id    = id,
		desc  = desc,
		price = price,
		img   = {}
	}

	-- Add Images to table:
	for i=1, 3 do
		local img = imgs[i] or imgs[1]
		table.insert(temp.img, img)
	end

	return temp
end

--[[
*HOW TO ADD OWN SKINS:
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*Function Structure:
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
	init(
		String: name,
		String: id,           >(must be unique)
		String: description,
		Int:    price,        >(to have it unlocked by default, set price to 0)
		Table:  skins
	)


*Skin Table Structure:
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
	Skin Tables can have three input images, but dont have to have every slot
	occupied.
	If a frame is left empty or is set to nil, the idle frame will be used as
	a replacement, as it is the only mandatory frame to have.

	Löve2d has a function called "love.graphics.newImage(...)".
	Use it to load your image, replacing "..." with the actual path.

	*Example:
	¯¯¯¯¯¯¯¯¯¯
	{
		love.graphics.newImage("assets/img/skins/MY_CUSTOM_SKIN_idle.png"),
		love.graphics.newImage("assets/img/skins/MY_CUSTOM_SKIN_flop.png"),
		love.graphics.newImage("assets/img/skins/MY_CUSTOM_SKIN_dead.png")
	}

	! NOTE:
	! ¯¯¯¯¯¯
	!  love.graphics.newImage() can only be used on images placed in
	!  directories that actually get compiled! You cannot load images from
	!  the same directory your .love or .exe is in!
]]


skins = {
	init(
		"Old Classic",
		"default",
		"This bird seems familiar...",
		0,
		{image.skin.default}
	),
	init(
		"Pupsbird",
		"pupsbird",
		"A very friendly alien bird.", 
		25,
		{image.skin.pupsbird.idle, image.skin.pupsbird.flop, image.skin.pupsbird.dead}
	),
	init(
		"duck.jpg",
		"duckjpg",
		"wha- what? Why is this duck here?",
		69,
		{image.skin.duckjpg}
		-- Picture Credit: https://pixabay.com/photos/duck-bird-mallard-water-bird-3712779/
	),
	init(
		"Nue",
		"air",
		"An air element, which loves chatting!",
		200,
		{image.skin.air.idle, image.skin.air.flop, image.skin.air.dead}
		-- Art Credit: Kura (https://www.instagram.com/kur.a.rt/)
	),
	init(
		"Plumber",
		"plumber",
		"A plumber you recognise from somewhere...",
		80,
		{image.skin.plumber.idle, image.skin.plumber.flop, image.skin.plumber.dead}
		-- Art Credit: Kura (https://www.instagram.com/kur.a.rt/)
	),
	init(
		"Bop-Cat",
		"bopbop",
		"The sight of this cat is hypnotising.",
		130,
		{image.skin.bopcat.idle, image.skin.bopcat.flop}
	)
}

for i,v in pairs(skins) do
	print(i .. " Loaded skin: " .. v.name)
end

return skins