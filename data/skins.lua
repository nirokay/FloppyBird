-- Format of skin init:
-- init( String, String, Int, Table { imgIDLE, imgFLOP, imgDEAD })

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


skins = {
	init("Old Classic", "default", "This bird seems familiar...",            0, {image.skin.default}),
	init("duck.jpg",    "duckjpg", "wha- what? Why is this duck here?",     40, {image.skin.duckjpg}),
	init("Bop-Cat",     "bopbop",  "The sight of this cat is hypnotising.", 69, {image.skin.bopcat.idle, image.skin.bopcat.flop})
}

for i,v in pairs(skins) do
	print(v.name)
end

return skins