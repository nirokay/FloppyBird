-- SETUP:
math.randomseed(os.time())

function love.load()
	-- Variables:
	width, height = love.graphics.getDimensions()
	require("import")
	debug = easy.debug
	easy.deb.isDebug = config.debugEnabled

	-- Save Files:
	save.init("score.dat", 0)
	save.init("skins.lua", "skins = {} return skins")

	-- Game Objects Declaration:

	--   Ground:
	ground = Ground(70)
	--   Pipes:
	pipe = {}
	regenerateAll()
	--   Player:
	player = Player(width/4, height/2)
	player.highscore = tonumber(save.load("score.dat"))
	--   Gui:
	gui    = Gui()

	--   Buttons:
	local c = {
		fg = {255, 255, 255, 1},
		bg = {160, 50, 50, 1}
	}
	button = {
		start = Button(3*width/5, 3*height/5, 170, 75, "left", "center", "Play", font.bttn, c.fg, c.bg, function()
			if button.start.text == "Play"
				then resetGame()
				else resetGame(true)
			end
			game.active = true
		end),
		quit  = Button(3*width/5, 4*height/5, 170, 75, "left", "center", "Quit", font.bttn, c.fg, c.bg, function()
			debug("", "Quitting Game. Bye bye!")
			love.event.quit()
		end)
	}

	-- Game Logic:
	game = {
		active = false,
		scroll = {
			speed     = config.scroll.speed,
			increment = config.scroll.increment,
			current   = config.scroll.speeds
		}
	}
	resetScroll()

	-- End of Setup:
	debug("", "Setup Completed!\n\n")
end


-- FUNCTIONS:

-- Dave Data:
function updateHighscore()
	save.save("score.dat", player.highscore)
end

-- Reset Game:
function resetGame(alsoPipes)
	-- Reset Objects:
	player:reset()
	resetScroll()
	if alsoPipes then
		regenerateAll()
	end

	-- Reset Game Logic:
	ground.doAttract = false
	player.alive = true
	hurtplayed = false

	-- Edit Start Button Text:
	button.start.text = "Retry"
end

-- Reset Scroll:
function resetScroll()
	game.scroll.speed     = config.scroll.speed
	game.scroll.increment = config.scroll.increment
	game.scroll.current   = game.scroll.speed
end

-- Player Dies:
function playerFail()
	if not hurtplayed then
		-- State Update:
		game.active = false
		player.alive = false
		ground.doAttract = true

		-- Animation and Sound:
		player:jump(0.3)
		love.audio.play(sound.hurt)
		updateHighscore()

		-- No-loop Loop thingy:
		hurtplayed = true
	end
end

-- Pipes:
function regenerateAll()
	pipe = {}
	for i=1, config.pipe.amount do
		table.insert(pipe, Pipe( config.pipe.startGap + i * config.pipe.distance ))
	end
end



-- MAIN:

function love.update(dt)
	ground:update()
	if game.active then
		-- In-Game
		player:update()
		for i, p in pairs(pipe) do
			p:update()
		end

	else
		-- Outside Game:
		for i, b in pairs(button) do
			b:update()
		end
	end

	gui:update()
end

function love.draw()
	-- Set BAckground Colour:
	local c = config.colour.sky
	love.graphics.setBackgroundColor(c[1]/255, c[2]/255, c[3]/255)

	-- Draw Game Objects:
	for i, p in pairs(pipe) do
		p:draw()
	end
	ground:draw()
	player:draw()

	if not game.active then
		-- Outside Game:
		for i, b in pairs(button) do
			b:draw()
		end
	end

	gui:draw()
end
