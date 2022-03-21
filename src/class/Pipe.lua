Pipe = Class{}

function Pipe:init(x)
	-- Position and Dimensions:
	self.x, self.w = x, config.pipe.width
	self.gap = {
		top = 0,
		bottom = 0
	}
	self:regenerateGaps()

	-- Logic:
	self.passed = false
end


-- FUNCTIONS:

-- Regeneration:
function Pipe:regenerateAll()
	-- Update Position:
	self.x = self.x + config.pipe.amount * config.pipe.distance
	self.passed = false
	
	-- Update Gap:
	self:regenerateGaps()
end
function Pipe:regenerateGaps()
	local size = math.random(config.pipe.gap.min, config.pipe.gap.max)
	local space = 20
	local placement = math.random(space, height - ground.h - space - size )

	self.gap.top = placement
	self.gap.bottom = placement + size
end

-- Check Player Collision:
function Pipe:collision()
	if player.x + player.r >= self.x and player.x - player.r <= self.x + self.w then
		if not (player.y - player.r >= self.gap.top and player.y + player.r <= self.gap.bottom) then
			playerFail()
		end
	end
end

-- Check if player passed Pipe:
function Pipe:checkPass()
	if not self.passed and player.x > self.x + self.w/2 then
		-- Scroll Speed Increase:
		game.scroll.current = game.scroll.current + game.scroll.increment

		-- Update Score and Pipe Completion:
		player:gainScore()
		self.passed = true
	end
end

function Pipe:updatePosition()
	self.x = self.x - game.scroll.current

	-- Regenerate if off-screen:
	if self.x < -self.w*2 then
		self:regenerateAll()
	end
end


-- MAIN:

function Pipe:update()
	-- Check Collision:
	self:collision()
	self:checkPass()
	self:updatePosition()
end

function Pipe:draw()
	easy.setColour("table", config.colour.pipe)

	-- Draw Bottom:
	love.graphics.rectangle("fill", self.x, self.gap.bottom, self.w, height)
	-- Draw Top:
	love.graphics.rectangle("fill", self.x, self.gap.top, self.w, -height)
end