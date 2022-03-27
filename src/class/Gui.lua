Gui = Class{}

function Gui:init()
	
end


-- FUNCTIONS:

function score(x, y, offY)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(font.default)
	love.graphics.printf("Score:  "     .. player.score,     x, y, width, "left")
	love.graphics.printf("Highscore:  " .. player.highscore, x, y+offY, width, "left")
end

function coins(x, y, size)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(font.default)

	local img = image.coin
	local w, h = img:getWidth(), img:getHeight()
	love.graphics.draw(img, x, y, 0, size/w, size/h)

	local txt = player.coins
	w = 100
	love.graphics.printf(txt, x-w, y, w, "right")
end


-- MAIN:

function Gui:update()
end

function Gui:draw()
	score(20, 20, 30)
	coins(width-50, 20, 30)
end