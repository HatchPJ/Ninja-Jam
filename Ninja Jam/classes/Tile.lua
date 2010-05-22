Tile = {}
Tile.world      = nil
Tile.width      = nil
Tile.height     = nil
Tile.image      = nil
Tile.body       = nil
Tile.shape      = nil
Tile.geometry   = nil
Tile.x          = nil
Tile.y          = nil

function Tile:new(file)
	tile = {}
	setmetatable(tile, self)
	self.__index = self
	
	tile.image = love.graphics.newImage(file)
	tile.image:setFilter("nearest","nearest")
	
	tile.width  = tile.image:getWidth()
	tile.height = tile.image:getHeight()
	
	tile.geometry = { -- defines a rectangle by default
		-(tile.width/2), -(tile.height/2),
		-(tile.width/2),  (tile.height/2),
		 (tile.width/2),  (tile.height/2),
		 (tile.width/2), -(tile.height/2),
	}
	return tile
end

function Tile:create(x, y, world)
	self.x = x
	self.y = y
	if world then
		self.body  = love.physics.newBody(world, self.x, self.y)
		self.shape = love.physics.newPolygonShape(self.body,
	                                              unpack(self.geometry))
	end
end

function Tile:draw(x, y)
	if not x then x = 0 end
	if not y then y = 0 end
	love.graphics.draw(self.image, self.x + x, self.y + y)
end

--setters and getters
function Tile:setWidth(v)
	self.width = v
end
function Tile:setHeight(v)
	self.height = v
end
function Tile:setGeometry(...)
	self.geometry = arg
end
function Tile:setX(v)
	self.x = v
end
function Tile:setY(v)
	self.y = v
end

function Tile:getWidth()
	return self.width
end
function Tile:getHeight()
	return self.height
end
function Tile:getGeometry()
	return unpack(self.geometry)
end
function Tile:getX()
	return self.x
end
function Tile:getY()
	return self.y
end
