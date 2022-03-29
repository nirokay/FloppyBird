Background = Class{}

function Background:init()
	-- Objects:
	self.cloudX = 0
	self.cityX  = 0

	self.img = {
		clouds = image.background.clouds,
		cities = image.background.cities,
		sky    = image.background.sky
	}

	-- Logic stuff:
	self.move = 0
end

-- FUNCTIONS:

-- Reset:
function Background:reset()
	self.move = 0
	self.cityX = 0
end

-- Background:
function Background:backgroundDraw()
	-- Set Background Colour:
	local c = config.colour.sky
	love.graphics.setBackgroundColor(c[1]/255, c[2]/255, c[3]/255)

	-- Draw Gradient:
	local w, h = self.img.sky:getDimensions()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.img.sky, -10, 0, 0, 100, (height - ground.h) / h)
end

-- Clouds:
function Background:cloudsUpdate()
	local w, h = self.img.clouds:getDimensions()
	self.cloudX = self.cloudX + config.background.cloudSpeed

	-- Snap Back:
	if self.cloudX + w <= 0 or self.cloudX >= w then
		self.cloudX = 0
	end
end
function Background:cloudsDraw()
	local w, h = self.img.clouds:getDimensions()
	local scale = (height - ground.h) / h
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.img.clouds, self.cloudX,     0, 0, scale)
	love.graphics.draw(self.img.clouds, self.cloudX + w, 0, 0, scale)
	love.graphics.draw(self.img.clouds, self.cloudX - w, 0, 0, scale)
end

-- Cities:
function Background:citiesUpdate()
	local w, h = self.img.cities:getDimensions()

	-- Snap Back:
	if self.cityX + w <= 0 or self.cityX >= w then
		self.cityX = 0
	end
end
function Background:citiesDraw()
	local w, h = self.img.cities:getDimensions()
	local scale = (height - ground.h) / h
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.img.cities, self.cityX,     0, 0, scale)
	love.graphics.draw(self.img.cities, self.cityX + w, 0, 0, scale)
	love.graphics.draw(self.img.cities, self.cityX - w, 0, 0, scale)
end



-- MAIN:

function Background:update()
	self.move = self.move + 1

	-- Parallax movement:
	if game.active then
		self.cloudX = self.cloudX - (game.scroll.speed * config.prallax.clouds)
		self.cityX  = self.cityX - (game.scroll.speed * config.prallax.cities)
	end

	-- Other updates:
	self:citiesUpdate()
	self:cloudsUpdate()
end

function Background:draw()
	self:backgroundDraw()
	self:cloudsDraw()
	self:citiesDraw()
end