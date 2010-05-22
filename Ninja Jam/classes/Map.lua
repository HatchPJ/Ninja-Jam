require("classes/Tile.lua")

Map = { }
Map.width  = nil
Map.height = nil
Map.tile_w = nil
Map.tile_h = nil
Map.layers = { }
Map.tiles  = { }
Map.world  = nil

function Map:new(tile_w, tile_h, data, z)
	map = {}
	setmetatable(map, self)
	self.__index = self
	
	-- set tile size
	map.tile_w = tile_w
	map.tile_h = tile_h
	
	-- set map data
	if not z then
		table.insert(map.layers, data)
	else
		map.layers[z] = data
	end
	
	-- map.width is set to the width of the first row.
	map.width  = #data[1]
	map.height = #data
	
	-- setup the world
	map.world = love.physics.newWorld(map.width  * map.tile_w,
	                                  map.height * map.tile_h)
	map.world:setGravity(0, 700)
	map.world:setMeter(64)
	
	-- create the map objects in the world
	for i = 1, (map.height * map.width - 1) do
		local x = (i % map.width) + 1
		local y = math.floor((i / map.width) + 1)
		if data[y][x] ~= 0 then
			local tile = Tile:new("images/tiles/tile" .. data[y][x] .. ".gif")
			tile:create(map.world, (x-1) * tile:getWidth(), (y-1) * tile:getHeight())
			table.insert(map.tiles, tile)
		end
	end
	
	return map
end

function Map:draw(x, y)
	for i, v in ipairs(map.tiles) do
		v:draw(x, y)
	end
end

function Map:addLayer(data, z)
	if not z then
		table.insert(self.layers, data)
	else
		self.layers[z] = data
	end
end

function Map.deleteLayer(z)
	
end

--setters and getters
function Map:setWidth(v)
	self.width = v
end
function Map:setHeight(v)
	self.height = v
end
function Map:setTiles(tiles)
	self.tiles = tiles
end

function Map:getWidth()
	return self.width
end
function Map:getHeight()
	return self.height
end
function Map:getTiles()
	return self.tiles
end
function Map:getLayer(z)
	return self.layers[z]
end
