Shopbutton = Class{}

function Shopbutton:init(x, y, w, h, skin, allOwned)
	self.x, self.y = x, y
	self.w, self.h = w, h
	self.skin = skin
	self.frames = {
		self.skin.img[1],
		self.skin.img[2]
	}
	self.animation = 1
	self.frame = 1

	self.s = (self.h - config.shop.indent*2)*0.75
	self.c = {
		fg = {255, 255, 255, 1},
		bg = {
			buy     = {221, 177, 44, 1},
			equip   = {140, 191, 45},
			equiped = {0, 0, 0, 1}
		} 
	}
	self.bought = false
	self.button = Button(self.x + self.w - self.s*0.5 - config.shop.indent, self.y + self.h/2, self.s*0.75, self.s*0.75, "center", "center", "Buy", font.shop.desc, self.c.fg, self.c.bg.buy, function() end)
	
	-- Unlock from save:
	for i, v in pairs(allOwned) do
		if v.id == self.skin.id then
			self.bought = true
		end
	end
	
	self:updateButton()
end


-- FUNCTIONS:

function Shopbutton:buy()
	if player.coins >= self.skin.price then
		save.append(files.skins, self.skin.id .. "\n")
		table.insert(shop.owned, self.skin)
		
		player.coins = player.coins - self.skin.price
		updateCoins()
		self.bought = true
	end
end

function Shopbutton:updateButton()
	if self.bought then
		self.button.text = "Equip"
		self.button.colour.bg = self.c.bg.equip
		self.button.fn = function()
			debug("", "Equipping skin: " .. self.skin.name)
			player.skin = self.skin
			self:updateButton()
		end
	else
		self.button.text = "Buy: " .. self.skin.price
		self.button.colour.bg = self.c.bg.buy
		self.button.fn = function()
			debug("", "Buying skin: " .. self.skin.name)
			self:buy()
			self:updateButton()
		end
	end

	if player.skin.id == self.skin.id then
		self.button.text = "Equiped"
		self.button.colour.bg = self.c.bg.equiped
		self.button.fn = function()
			debug("warn", "Already Equipped skin: " .. self.skin.name)
			self:updateButton()
		end
	end
end


-- MAIN:

function Shopbutton:update()
	self:updateButton()
	self.button:update()

	self.animation = self.animation + 1
	if self.animation >= config.shop.animationSpeed then
		self.animation = 0
		self.frame = self.frame + 1
	end
end

function Shopbutton:draw()
	-- Background:
	easy.setColour("single", 0, 0, 0, 0.4)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	-- Text:
	local indent = self.s + config.shop.indent*2 + self.x
	local space  = 30
	easy.setColour("single", 255, 255, 255, 1)

	love.graphics.setFont(font.shop.name)
	love.graphics.printf(self.skin.name, indent, self.y + config.shop.indent, self.w - indent*2 - config.shop.indent, "left")

	love.graphics.setFont(font.shop.desc)
	love.graphics.printf(self.skin.desc, indent, self.y + config.shop.indent + space, self.w - indent*2 - config.shop.indent, "left")

	-- Draw Bird:
	easy.setColour("single", 255, 255, 255, 1)
	local texture = self.frames[self.frame % #self.frames + 1]
	local w, h = texture:getWidth(), texture:getWidth()
	love.graphics.draw(texture, self.x + config.shop.indent, self.y + config.shop.indent, 0, (self.h - 8*config.shop.indent)/w, (self.h - 8*config.shop.indent)/h)

	-- Buy/Equip Button:
	self.button:draw()
end