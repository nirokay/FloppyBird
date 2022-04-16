save = {
	files = {}
}

function save.init(name, file, data)
	data = data or " "
	if not love.filesystem.getInfo(file) then
		debug("warn", "File *" .. file .. "* not found; Creating")
		love.filesystem.write(file, data)
	end
	save.files[name] = file
	debug("", "File *" .. file .. "* found!")
end

function save.load(file)
	if love.filesystem.getInfo(file) then
		debug("", "Loading File *" .. file .. "*. Following Data is imported:")
		local temp = love.filesystem.read(file)
		print( clr.bg.red .. tostring(temp) .. clr.reset)
		return temp
	else
		debug("error", "File *" .. file .. "* not found! Is init?")
	end
end

function save.save(file, data)
	love.filesystem.write(file, data)
end

function save.append(file, data)
	love.filesystem.append(file, data)
end


-- Custom Skins:
function save.loadCustomSkins()
	local pathSkins = "customskins"
	local listRaw   = love.filesystem.getDirectoryItems(pathSkins)
	local listSkin  = {}

	-- Filter out Directories:
	debug("warn", "Loading Custom Skins")
	for i, v in pairs(listRaw) do
		debug("warn", "Checking for directory: " .. v .. " (" .. love.filesystem.getInfo(pathSkins .. "/" .. v).type .. ")")
		if love.filesystem.getInfo(pathSkins .. "/" .. v).type == "directory" then
			table.insert(listSkin, v)
			debug("", "Custom skin: " .. v)
		end
	end

	-- Actually load skins:
	local function checkImg(path, failsafe)
		if love.filesystem.read(path) ~= nil
			then return love.graphics.newImage(path)
			else return failsafe
		end
	end
	for i, v in pairs(listSkin) do
		local path    = "temp/"
		local pathRaw = pathSkins .. "/" .. v .. "/"
		love.filesystem.mount(pathSkins .. "/" .. v .. "/", path)
		
		-- Skin Data:
		local name    = love.filesystem.read(path .. "name.txt") or "Custom Skin"
		local id      = v
		local desc    = love.filesystem.read(path .. "desc.txt") or "Custom Skin Description"
		local price   = tonumber(love.filesystem.read(path .. "price.txt") or 999)

		local img     = {}
		img[1] = checkImg("temp/1.jpg", image.missing)
		img[2] = checkImg("temp/2.jpg", img[1])
		img[3] = checkImg("temp/3.jpg", img[1])

		-- Add Skin to skins table:
		table.insert(skins, {
			name  = name,
			id    = id,
			desc  = desc,
			price = price,
			img   = img
		})
		img = {}
		debug("warn", "Unmounting " .. path)
		love.filesystem.unmount(pathRaw)
	end
end

return save