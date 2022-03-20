Button = Class {}

function Button:init(x, y, w, h, offPlaceX, offPlaceY, text, font, cF, cB, fn)
	-- Dimensions:
	self.x, self.y, self.w, self.h = x, y, w, h

	-- Placement Offset:
	--   X-Axis:
	local xOff, yOff = 0, 0
	if offPlaceX == "center" then
		xOff = 0.5
	elseif offPlaceX == "right" then
		xOff = 1
	elseif offPlaceX == "left" then
		xOff = 0
	end
	--   Y-Axis:
	if offPlaceY == "center" then
		yOff = 0.5
	elseif offPlaceY == "bottom" then
		yOff = 1
	elseif offPlaceY == "top" then
		yOff = 0
	end
	self.x, self.y = self.x - self.w*xOff, self.y - self.h*yOff

	-- Text and Colour:
	self.text = text
	self.font = font
	self.colour = {
		bg = cB,
		fg = cF
	}
	self.pop = 0

	-- Button Cooldown:
	self.cooldown = {
		max = 10,
		current = 0
	}

	-- Function:
	local debugFN = fn
	if fn == nil then
		self.fn = function()
			easy.debug("warn", "This Button (*" .. self.text .. "*) has no function!")
		end
	else
		self.fn = fn
	end

	-- Debug:
	easy.debug("normal", "Button: *" .. self.text .. "* asigned: *" .. tostring(debugFN) .. "*!")
end

-- FUNCTIONS:




-- MAIN:

function Button:update()
	-- Cooldown Trickle Down:
	if self.cooldown.current > -5 then
		self.cooldown.current = self.cooldown.current - 1
	end

	-- Click Check:
	if easy.mouse.click(self.x, self.y, self.w, self.h, 1) then                -- ! "controls.mouse.click" in place of "1" doesnt work and idk why
		-- Click only after Cooldown:
		if self.cooldown.current < 0 then
			self.fn()
		end
		-- Reset Cooldown after Click:
		self.cooldown.current = self.cooldown.max
	end
end

function Button:draw()
	local x, y, w, h = self.x, self.y, self.w, self.h
	local popMax = 5
	
	-- Slow Pop Rise/Sink:
	local popRise = 0.25
	if easy.mouse.hover(self.x, self.y, self.w, self.h) then
		if self.pop <= popMax then
			self.pop = self.pop + popRise
		end
	else
		if self.pop >= 0 then
			self.pop = self.pop - popRise
		end
	end
	local pop = self.pop

	-- Pop Effect when Hover Over:
	if easy.mouse.hover(self.x, self.y, self.w, self.h) and self.cooldown.current < 0 then
		x, y, w, h = x-pop, y-pop, w+pop*2, h+pop*2
	end

	-- Draw Background:
	easy.setColour("table", self.colour.bg)
	love.graphics.rectangle("fill", x, y, w, h)

	-- Draw Text:
	local yOff = 0
	easy.setColour("table", self.colour.fg)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text, self.x, self.y + yOff, self.w, "center")
end