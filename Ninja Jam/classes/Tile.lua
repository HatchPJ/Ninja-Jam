Tile = {}
Tile.world    = nil
Tile.width    = nil
Tile.height   = nil
Tile.image    = nil
Tile.body     = nil
Tile.shape    = nil
Tile.geometry = nil
Tile.x        = nil
Tile.y        = nil

function Tile:new(file, width, height)
	tile = {}
	setmetatable(tile, self)
	self.__index = self
	
	tile.image = love.graphics.newImage(file)
	tile.image:setFilter("nearest","nearest")
	
	tile.width  = width  or tile.image:getWidth()
	tile.height = height or tile.image:getHeight()
	
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

function Tile:draw(x, y, angle, sx, sy, ox, oy)
	love.graphics.draw(self.image, x, y, angle, sx, sy, ox, oy)
end

--setters and getters
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
