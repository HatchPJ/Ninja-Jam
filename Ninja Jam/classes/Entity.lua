Entity = { }
Entity.x      = nil
Entity.y      = nil
Entity.width  = nil
Entity.height = nil
Entity.anims  = { }
Entity.anim   = nil
Entity.states = { }
Entity.state  = nil
Entity.body   = nil
Entity.shape  = nil
Entity.world  = nil

function Entity:draw(x, y, angle, sx, sy, ox, oy)
	-- rotation: x=x*cos(r) - y*sin(r), y=x*sin(r) + y*cos(r) 
	local final_x = ( (self.x * math.cos(angle)) -
	                  (self.y * math.sin(angle)) )
	local final_y = ( (self.x * math.sin(angle)) +
	                  (self.y * math.cos(angle)) )
	
	-- scale
	final_x = final_x * sx
	final_y = final_y * sy
	
	-- position offset
	final_x = final_x + x
	final_y = final_y + y
	
	self.anim:draw(final_x, final_y, angle, sx, sy, ox, oy)
end

function Entity:addAnim(title, file, fw, fh, delay, frames)
	local image = love.graphics.newImage(file)
	image:setFilter("nearest", "nearest")
	self.anims[title] = newAnimation(image, fw, fh, delay, frames)
end

function Entity:addState(title)
	self.states[title] = title
end

function Entity:setAnim(title)
	self.anim = self.anims[title]
end

function Entity:setState(title)
	self.state = self.states[title]
end
