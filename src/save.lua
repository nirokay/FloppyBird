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

return save