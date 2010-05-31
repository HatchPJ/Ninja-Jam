require("classes/Entity.lua")

Actor = { }
Actor.speed  = nil
Actor.health = nil

function Actor:new()
	actor = Entity:new()
	setmetatable(actor, self)
	self.__index = self
	
	return actor
end

function Actor:create(world, body, shape)
	self.world = world
	self.body  = body
	self.shape = shape
end
