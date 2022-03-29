-- SETUP:
math.randomseed(os.time())
love.math.setRandomSeed(os.time())

function love.load()
	-- Variables:
	width, height = love.graphics.getDimensions()
	require("import")
	debug = easy.debug
	easy.deb.isDebug = config.debugEnabled

	-- Save Files:
	save.init("score", files.score, 0)
	save.init("coins", files.coins, 0)
	save.init("skins", files.skins, "default\n")

	-- Game Objects Declaration:
	--   Ground:
	ground = Ground(70)
	--   Background:
	background = Background()
	--   Pipes:
	pipe = {}
	regenerateAll()
	--   Player:
	player = Player(width/4, height/2)
	player.highscore = tonumber(save.load("score.dat"))
	player.coins     = tonumber(save.load("coins.dat"))
	--   Gui:
	gui    = Gui()
	shop   = Shop()

	--   Buttons:
	local c = {
		fg = {255, 255, 255, 1},
		bg = {160, 50, 50, 1}
	}
	button = {
		start = Button(5*width/7, 2*height/5, 170, 75, "left", "center", "Play", font.bttn, c.fg, c.bg, function()
			if button.start.text == "Play"
				then resetGame()
				else resetGame(true)
			end
			game.active = true
		end),
		shop  = Button(5*width/7, 3*height/5, 170, 75, "left", "center", "Shop", font.bttn, c.fg, c.bg, function()
			shop.active = not shop.active
		end),
		quit  = Button(5*width/7, 4*height/5, 170, 75, "left", "center", "Quit", font.bttn, c.fg, c.bg, function()
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
			current   = config.scroll.speed
		},
		restartCooldown = {
			current = 0,
			max = 40
		}
	}
	resetScroll()

	-- End of Setup:
	debug("", "Setup Completed!\n\n")
end


-- FUNCTIONS:

-- Save Data:
function updateHighscore()
	save.save(files.score, player.highscore)
end

function updateCoins()
	save.save(files.coins, player.coins)
end

-- Reset Game:
function resetGame(alsoPipes)
	-- Reset Objects:
	player:reset()
	background:reset()
	player.frame = player.skin.img[1]
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
		shop.active = false
		game.restartCooldown.current = game.restartCooldown.max
		player.alive = false
		ground.doAttract = true

		-- Update Player Coins:
		local temp = save.load("coins.dat")
		player.coins = tonumber(temp) + math.floor(player.score * config.player.coinGain)
		save.save("coins.dat", player.coins)

		-- Animation and Sound:
		player:jump(0.3)
		player.frame = player.skin.img[3]
		easy.sound.playRandom(sound.player.hurt)
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

-- Quick Restart (Press Space to replay when dead)
function quickRestart()
	-- Press jump button if dead to quick restart:
	if love.keyboard.isDown(controls.player.jump) then
		if game.restartCooldown.current < 0 then
			button.start.fn()
		end
		game.restartCooldown.current = game.restartCooldown.max
	end
	game.restartCooldown.current = game.restartCooldown.current - 1
end



-- MAIN:

function love.update(dt)
	width, height = love.graphics.getDimensions()

	background:update()
	ground:update()
	if game.active then
		-- In Game:
		player:update()
		for i, p in pairs(pipe) do
			p:update()
		end

	else
		-- Outside Game:
		if shop.active then
			-- Shop is active:
			shop:update()
		else
			-- Shop isn't Active:
			quickRestart()
		end

		for i, b in pairs(button) do
			b:update()
		end
	end

	gui:update()
end

function love.draw()
	background:draw()

	-- Draw Game Objects:
	for i, p in pairs(pipe) do
		p:draw()
	end
	ground:draw()
	player:draw()

	if not game.active then
		-- Button Draw:
		for i, b in pairs(button) do
			b:draw()
		end

		if shop.active then
			-- Shop Draw:
			shop:draw()
		end
	end

	gui:draw()
end
