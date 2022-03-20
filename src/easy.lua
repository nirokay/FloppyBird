easy = {
	-- All Stuff Debug:
	deb = {
		isDebug = false,
		gap = 0,
		types = {
			{
				dsc = "normal",
				col = clr.fg.WHITE,
				txt = "DEBUG:"
			},
			{
				dsc = "warn",
				col = clr.fg.YELLOW,
				txt = "WARNING:"
			},
			{
				dsc = "error",
				col = clr.fg.RED,
				txt = "ERROR:"
			}
		}
	},

	-- All Stuff Mouse:
	mouse = {}
}

-- Debug Indentation:
local function addGaps()
	local types = easy.deb.types

	-- Get the longest string char count:
	local maxL = 0
	for i=1, #types do
		if #types[i].txt> maxL then
			maxL = #types[i].txt
		end
	end

	-- Calculate Indentation:
	local gap = 2
	for i=1, maxL do
		gap = gap + 1
	end
	easy.deb.gap = gap
end
addGaps()

-- Debug Printing Tool:
function easy.debug(type, text)
	if easy.deb.isDebug then
		local types = easy.deb.types 
		local id = nil
		local maxL = 2
		type = tostring(type)
		text = tostring(text)

		-- Checks if given type matches one:
		for i=1, #types do
			if types[i].dsc == tostring(type) then
				id = i
			end
		end
		-- If no match, generic debug:
		id = id or 1

		-- Indentation:
		local gap = ""
		for i = #types[id].txt, easy.deb.gap do
			gap = gap .. " "
		end

		-- Print Debug Text:
		print(types[id].col .. types[id].txt .. gap .. text .. clr.reset)
	end
end

-- Easy setColour() with 0-range (default: 255):
function easy.setColour(type, r, g, b, a)
	local range = 255

	-- Handles Input (Table or Individuals):
	if type == "table" then
		-- Input is a table:
		local tab = r
		r, g, b, a = tab[1], tab[2], tab[3], tab[4]
	elseif type == "single" then
		-- Input is all colour values individually:
	else
		easy.debug("error", "Invalid Colour Selection!")
	end

	-- Corrections:
	--   No alpha provided:
	if a == nil then a = 1 end
	--   Monochrome:
	if g == nil and b == nil then g, b = r, r end

	-- Set Colour:
	love.graphics.setColor(r/range, g/range, b/range, a)
end

-- Mouse Hover and Click:
function easy.mouse.hover(x, y, w, h)
	local mx, my = love.mouse.getPosition()
	local isHover = false
	if (mx >= x and mx <= x + w) and (my >= y and my <= y + h) then
		isHover = true
	end
	return isHover
end
function easy.mouse.click(x, y, w, h, button)
	local isClick = false
	if easy.mouse.hover(x, y, w, h) and love.mouse.isDown(button) then
		isClick = true
	end
	return isClick
end

return easy