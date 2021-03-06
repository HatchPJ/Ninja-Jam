require("classes/Tile.lua")

Map = { }
Map.width  = nil
Map.height = nil
Map.tile_w = nil
Map.tile_h = nil
Map.layers = { }
Map.tiles  = { }
Map.world  = nil

function Map:new(tile_w, tile_h, layers)
	map = {}
	setmetatable(map, self)
	self.__index = self
	
	-- set tile size
	map.tile_w = tile_w
	map.tile_h = tile_h
	
	-- set map data
	map.layers = layers
	
	-- map.width is set to the width of the first row of the first
	-- layer. map.height is from first layer as well. Be consistent.
	map.width  = #map.layers[1][1]
	map.height = #map.layers[1]
	
	-- setup the world
	map.world = love.physics.newWorld(map.width  * map.tile_w,
	                                  map.height * map.tile_h)
	map.world:setGravity(0, 700)
	map.world:setMeter(64)
	
	-- create the map objects in the world
	for i, layer in ipairs(map.layers) do
		map.tiles[i] = { }
		for j = 1, (map.height * map.width - 1) do
			local x = (j % map.width) + 1
			local y = math.floor((j / map.width) + 1)
			if layer[y][x] ~= 0 then
				local tile = Tile:new("images/tiles/tile" .. layer[y][x] .. ".gif")
				if map.layers[i].collision then
					tile:create((x-1) * tile:getWidth(), (y-1) * tile:getHeight(), map.world)
				else
					tile:create((x-1) * tile:getWidth(), (y-1) * tile:getHeight())
				end
				table.insert(map.tiles[i], tile)
			end
		end
	end
	
	return map
end

function Map:draw(x, y, angle, sx, sy, ox, oy, ...)
	local layers
	local layer
	
	if arg.n ~= 0 then
		layers = #arg
	else
		layers = #self.tiles
	end
	
	for i = 1, layers do
		if arg.n ~= 0 then
			layer = arg[i]
		else
			layer = i
		end
		for i, tile in ipairs(self.tiles[layer]) do
			
			-- rotation: x=x*cos(r) - y*sin(r), y=x*sin(r) + y*cos(r) 
			final_x = ( (tile:getX() * math.cos(angle)) -
			            (tile:getY() * math.sin(angle)) )
			final_y = ( (tile:getX() * math.sin(angle)) +
			            (tile:getY() * math.cos(angle)) )
			
			-- scale
			final_x = final_x * sx
			final_y = final_y * sy
			
			-- position offset
			final_x = final_x + x
			final_y = final_y + y
			
			tile:draw(final_x, final_y, angle, sx, sy, ox, oy)
		end
	end
end

--getters; nothing to set, really
function Map:getTileWidth()
	return self.tile_w
end
function Map:getTileHeight()
	return self.tile_h
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
function Map:getWorld()
	return self.world
end
