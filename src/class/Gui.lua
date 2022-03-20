Gui = Class{}

function Gui:init()
	
end


-- FUNCTIONS:



-- MAIN:

function Gui:update()
end

function Gui:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(font.default)
	love.graphics.printf("Score:  "     .. player.score,     20, 20, width, "left")
	love.graphics.printf("Highscore:  " .. player.highscore, 20, 50, width, "left")
end