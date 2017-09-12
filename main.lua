-- @Author: Debray Arnaud <adebray>
-- @Date:   2017-09-12T03:13:09+02:00
-- @Email:  adebray@student.42.fr
-- @Last modified by:   adebray
-- @Last modified time: 2017-09-12T03:16:50+02:00

x_offset, y_offset = 0, 0
width, height = 5, 10
scale = 10
nbr = 2048

color_table = {
	{ r = 100, g =  20, b = 100 },
	{ r = 244, g = 154, b = 194 },
	{ r = 175, g = 198, b = 207 },
	{ r = 130, g = 105, b =  83 },
	{ r = 179, g = 158, b = 181 },
	{ r = 255, g = 179, b =  71 },
	{ r =   3, g = 192, b =  60 },
	{ r = 203, g = 153, b = 201 },
	{ r = 222, g = 165, b = 164 },
	{ r = 150, g = 111, b = 214 },
	{ r = 119, g = 158, b = 203 },
	{ r = 255, g = 105, b =  97 },
	{ r = 253, g = 253, b = 150 },
	{ r = 207, g = 207, b = 196 },
	{ r = 119, g = 190, b = 119 },
	{ r = 194, g =  59, b =  34 },
	{ r = 255, g = 209, b = 220 }
}

function love.load()
	w_count = (love.graphics.getWidth() / width)
	h_count = (love.graphics.getHeight() / height)

	canvas_list = {}
	for i=0, nbr - 1 do
		makeCanvas(width, height)
	end

	-- canvas = love.graphics.newCanvas(love.window.getWidth(), love.window.getHeight())

	-- love.graphics.setCanvas(canvas)
	-- 	love.graphics.setColor(255, 255, 255, 255)
	-- 	local x, y = 0, 0

	-- 	for i,v in ipairs(canvas_list) do
	-- 		love.graphics.draw(v, x_offset + x, y_offset + y)
	-- 		love.graphics.draw(v, x_offset + x + width * 2, y_offset + y, 0, -1, 1)

	-- 		x = x + (width * 2)
	-- 		if (x + ((width * 2)) >= love.window.getWidth()) then
	-- 			x = 0
	-- 			y = y + (height)
	-- 		end
	-- 	end
	-- love.graphics.setCanvas()

	-- canvas:getImageData():encode("test.png")
end

function makeCanvas(width, height)
	local canvas = love.graphics.newCanvas(width, height)
	canvas:setFilter("nearest", "nearest")

	local color = love.math.random(1, #color_table)
	local seed = love.math.random(0, 1024)

	love.graphics.setCanvas(canvas)

		for i=0,width - 1 do
			for j=0,height - 1 do
				local noise = love.math.random()

				if noise > 0.5 then
					love.graphics.setColor(255, 255, 255, 255)
				else
					love.graphics.setColor(color_table[color].r, color_table[color].g, color_table[color].b, 255)
				end

				love.graphics.rectangle('fill', i + 0, j + 0, 1, 1)
			end
		end

	love.graphics.setCanvas()
	table.insert(canvas_list, canvas)
end

function love.update(dt)
	if love.keyboard.isDown('up') then y_offset = y_offset - dt * 1000 end
	if love.keyboard.isDown('down') then y_offset = y_offset + dt * 1000 end
	if love.keyboard.isDown('left') then x_offset = x_offset - dt * 1000 end
	if love.keyboard.isDown('right') then x_offset = x_offset + dt * 1000 end
end

function love.mousepressed( x, y, button)
	if button == 'wd' then scale = scale - 0.1 end
	if button == 'wu' then scale = scale + 0.1 end
end

function love.draw()
	-- love.graphics.draw(canvas)
	love.graphics.setColor(255, 255, 255, 255)
	local x, y = 0, 0

	for i,v in ipairs(canvas_list) do
		love.graphics.draw(v, x_offset + x, y_offset + y, 0, scale, scale)
		love.graphics.draw(v, x_offset + x + width * scale * 2, y_offset + y, 0, -scale, scale)

		x = x + (width * scale * 2) + 2
		if (x + ((width * 2) * scale) >= love.graphics.getWidth()) then
			x = 0
			y = y + (height * scale) + 2
		end
	end
end
