Player = Class{}

function Player:init(x, y)
	-- Position and Dimensions:
	self.x, self.y = x, y
	self.xStart, self.yStart = x, y
	self.r = config.player.radius
	self.ySpeed = config.player.startSpeed

	-- Score Setup:
	self.score = 0
	self.coins = 0
	self.highscore = 0

	-- Current Skin and Picture related stuff:
	self.angle = math.pi/2
	self.skin = image.skin.default

	-- Controls Stuff:
	self.cooldown = {
		max = 5,
		current = 0
	}

	-- Logic Stuff:
	self.alive = true
end


-- FUNCTIONS:

-- Reset Player:
function Player:reset()
	self.x = self.xStart
	self.y = self.yStart

	self.ySpeed = config.player.startSpeed
	self.angle = math.pi/2

	self.alive  = true
	self.score  = 0
end

-- * Score Stuff: ( called on Pipe Passage by Pipe.lua, not here )
function Player:gainScore()
	self.score = self.score + 1
	love.audio.play(sound.yay)

	if self.score > self.highscore then
		self.highscore = self.score
	end
end

-- Player Controls:
function Player:controls()
	-- Keyboard Input:
	local function keyDown(key, fn)
		if love.keyboard.isDown(key) then fn() end
	end
	-- Mouse Input:
	local function mouseDown(key, fn)
		if love.mouse.isDown(key) then fn() end
	end


	-- CONTROL FUNCTIONS:

	-- Full Jump Function:
	local function jump()
		if self.cooldown.current < 0 then
			self:jump()
		end
		self.cooldown.current = self.cooldown.max
	end


	-- ALL CONTROLS:
	keyDown(controls.player.jump, function()
		jump()
	end)
	mouseDown(controls.mouse.click, function()
		jump()		
	end)

	-- Cooldown Trickle Down:
	self.cooldown.current = self.cooldown.current - 1
end

function Player:jump(perc)
	perc = perc or 1
	self.ySpeed = config.player.jump * perc
	love.audio.play(sound.jump)
end

function Player:gravity()
	self.ySpeed = self.ySpeed - config.player.gravity

	local max = config.player.maxSpeed
	if self.ySpeed > max then
		self.ySpeed = max
	elseif self.ySpeed < -max then
		self.ySpeed = -max
	end
end

function Player:updatePosition()
	self:gravity()
	self.y = self.y - self.ySpeed
end


-- MAIN:

function Player:update()
	if self.alive then
		self:controls()
		self:updatePosition()
	else
		self.ySpeed = 0
	end

	-- Rotation Over-/Underflow:
	if self.angle > math.pi*2 then 
		self.angle = 0
	elseif self.angle < 0 then 
		self.angle = math.pi*2
	end
	self.angle = (self.ySpeed/config.player.maxSpeed) + math.pi/2
end

function Player:draw()
	easy.setColour("table", config.colour.bird)
	love.graphics.circle("fill", self.x, self.y, self.r)

	local w, h = self.skin:getWidth(), self.skin:getWidth()
	local scale = self.r / w*2.5
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.skin, self.x, self.y, -(self.angle-math.pi/2), scale, scale, w/2, h/2)
end
