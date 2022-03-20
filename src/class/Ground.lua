Ground = Class{}

function Ground:init(h)
	self.h = h
	self.doAttract = false
end

-- FUNCTIONS:

-- Collision with Player:
function Ground:collison()
	if player.y + player.r >= height - self.h then
		playerFail()
	end
end

-- Attract Player to ground if they died:
function Ground:attractPlayer()
	if not player.alive then
		-- Attract Player to ground:
		if self.attractPlayer and player.y + player.r <= height - self.h then
			player:updatePosition()
		end

		-- Anti-clip:
		if player.y + player.r > height - self.h then
			player.y = height - self.h - player.r
		end
	end
end


-- MAIN:

function Ground:update()
	self:collison()
	self:attractPlayer()
end

function Ground:draw()
	-- Draw Dirt:
	easy.setColour("table", config.colour.ground.dirt)
	love.graphics.rectangle("fill", -5, height - self.h, width+10, self.h + 5)

	-- Draw Grass:
	easy.setColour("table", config.colour.ground.grass)
	love.graphics.rectangle("fill", -5, height - self.h, width+10, self.h/4)
end