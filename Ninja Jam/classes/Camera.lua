Camera = { }
Camera.x        = nil
Camera.y        = nil
Camera.scale_x  = nil
Camera.scale_y  = nil
Camera.rotation = nil

function Camera:new(x, y, r, sx, sy)
	camera = {}
	setmetatable(camera, self)
	
	camera.x        = x  or 0
	camera.y        = y  or 0
	camera.scale_x  = sx or 0
	camera.scale_y  = sy or 0
	camera.rotation = r  or 0
	
	self.__index = self	
	return camera
end

function Camera:move(x, y)
	camera.x = camera.x + x
	camera.y = camera.y + y
end

function Camera:setX(v)
	self.x = v
end
function Camera:setY(v)
	self.y = v
end
function Camera:setScaleX(v)
	self.scale_x = v
end
function Camera:setScaleY(v)
	self.scale_y = v
end
function Camera:setRotation(v)
	self.rotation = v
end

function Camera:getX(v)
	return self.x
end
function Camera:getY(v)
	return self.y
end
function Camera:getScaleX(v)
	return self.scale_x
end
function Camera:getScaleY(v)
	return self.scale_y
end
function Camera:getRotation()
	return self.rotation
end
