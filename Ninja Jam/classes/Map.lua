Map = { }
Map.width  = nil
Map.height = nil
Map.layers = nil
Map.tiles  = nil

function Map:new(width, height)
	map = {}
	setmetatable(map, self)
	self.__index = self
	
	map.width  = width
	map.height = height
	
	return map
end

-- a layer should be a 2-dimensional array of Tile objects
function Map.addLayer(data, z)
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
	return self.layer[z]
end
