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
	local startY = height - self.h
	-- Draw Dirt:
	easy.setColour("table", config.colour.ground.dirt)
	love.graphics.rectangle("fill", -5, startY, width+10, self.h + 5)

	-- Draw Grass:
	easy.setColour("table", config.colour.ground.grass)
	love.graphics.rectangle("fill", -5, startY, width+10, self.h/3)

	-- Draw Shadow:
	local squish = 3
	local val    = (500 / ( 0.05 * (math.abs(startY - player.y) ) + player.r))
	love.graphics.setColor(0, 0, 0, 0.2)
	love.graphics.ellipse("fill", player.x, startY + val/squish, val, val/3)
end