Shop = Class{}

function Shop:init()
	self.active = false
	self.x, self.y = 20, height/8
	self.w, self.h = 3*width/5, height - self.y*2

	local skins = require("data/skins")
	self.owned = self:load()

	local size   = config.shop.pageButton
	local indent = config.shop.indent
	local c = {
		bg = {0, 0, 0, 0.3},
		fg = {255, 255, 255, 1}
	}
	self.buttons = {
		pageUP   = Button(self.x + indent + size/2, self.y + indent + size/2, size-indent*2, size-indent*2, "center", "center", "<", font.default, c.fg, c.bg, function()
			self:changePage("-")
			love.audio.play(sound.ui.page.down)
		end),
		pageDOWN = Button(self.x - indent - size/2 + self.w, self.y + indent + size/2, size-indent*2, size-indent*2, "center", "center", ">", font.default, c.fg, c.bg, function()
			self:changePage("+")
			love.audio.play(sound.ui.page.up)
		end)
	}

	
	-- Load Skins onto pages:
	self.inStore = {}
	for i=1, 10 do
		table.insert(self.inStore, {})
	end

	for i, v in pairs(skins) do
		local id = i % (config.shop.skinsPerPage)

		local w = self.w - config.shop.indent * 2
		local h = self.h / config.shop.skinsPerPage - config.shop.spacing*2

		local x = self.x + config.shop.indent
		local y = self.y + (h + config.shop.indent)*(id) + size + config.shop.indent*4

		local temp = Shopbutton(x, y, w, h, v, self.owned)
		table.insert(self.inStore[math.floor(i / config.shop.skinsPerPage + 1)], temp)
	end
	self.page  = 1
	self.pages = math.floor(#self.inStore)
end


-- FUNCTIONS:

-- Change Page (Used for page control buttons):
function Shop:changePage(dir)
	local dif = 0
	if dir == "+" then
		dif =  1
	elseif dir == "-" then
		dif = -1
	end

	-- Apply Page:
	self.page = self.page + dif
	
	-- Under-/Overflow:
	if self.page < 1 then
		self.page = self.pages
	end
	if self.page > self.pages then
		self.page = 1
	end
end

-- Initial Skin Loading (from save file):
function Shop:load()
	-- Load Skin IDs:
	local tabl = {}
	for line in love.filesystem.lines(files.skins) do
		table.insert(tabl, line)
	end

	-- Unlock Skins from save file:
	local unlocked = {}
	for i, u in pairs(tabl) do -- Loop through save file unlocks:
		for k, s in pairs(skins) do -- Loop through every available skin:
			if u == s.id or tonumber(s.price) <= 0 then
				table.insert(unlocked, s)
				debug("", "Unlocked Skin Loaded: " .. s.name)
			end
		end
	end
	return unlocked
end


-- MAIN:

function Shop:update()
	for i, b in pairs(self.buttons) do
		b:update()
	end
	for i, v in pairs(self.inStore[self.page]) do
		v:update()
	end
end

function Shop:draw()
	local width, height = self.w, self.h
	-- Background:
	easy.setColour("single", 0, 0, 0, 0.1)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	-- Top Page Bar:
	love.graphics.rectangle("fill", self.x, self.y, self.w, config.shop.pageButton + config.shop.indent*2)

	love.graphics.setFont(font.default)
	easy.setColour("single", 255, 255 , 255, 1)
	love.graphics.printf("Page " .. self.page .. "/" .. self.pages, self.x + config.shop.pageButton, self.y + config.shop.pageButton/3, self.w - config.shop.pageButton*2, "center")

	for i, b in pairs(self.buttons) do
		b:draw()
	end

	for i, v in pairs(self.inStore[self.page]) do
		v:draw()
	end
end
