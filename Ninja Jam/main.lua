require("lib/AnAL.lua")
require("classes/Tile.lua")
require("classes/Map.lua")
require("classes/Camera.lua")
require("player.lua")
require("maps/map1.lua")

SCREEN_WIDTH  = 640
SCREEN_HEIGHT = 480

love.graphics.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, false, true, 0)

map = Map:new(8, 8, layers)
camera = Camera:new(0, 0, 0, 1, 1)

player.body = love.physics.newBody(map.world, 0, 0, 5, 0)
player.shape = love.physics.newRectangleShape(player.body, 0, 0, player.width, player.height, 0)

function love.update(dt)
	map.world:update(dt)
	player.anim:update(dt)
	
	player.move.x, player.move.y = player.body:getLinearVelocity()
	player.x, player.y = player.body:getPosition()
	
	camerax = -( (player.x * math.cos(camera:getRotation())) -
	             (player.y * math.sin(camera:getRotation())) )
	cameray = -( (player.x * math.sin(camera:getRotation())) +
	             (player.y * math.cos(camera:getRotation())) )
	
	camerax = camerax * camera:getScaleX()
	cameray = cameray * camera:getScaleY()

	camera:setX(camerax + SCREEN_WIDTH/2)
	camera:setY(cameray + SCREEN_HEIGHT/2)
	
	if player.move.x < 50 and player.move.x > -50 then
		if player.anim == player.anims["run left"] then
			player:setAnim("idle left")
		elseif player.anim == player.anims["run right"] then
			player:setAnim("idle right")
		end
	end
	
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		if player.inair == false then
			player.body:applyForce(player.speed, 0)
		elseif player.inair == true then
			player.body:applyForce(player.speed/3, 0)
		end
		if player.move.x >= player.speed then
			player.body:setLinearVelocity(player.speed, player.move.y)
		end
		player:setAnim("run right")
	end
	
	if love.keyboard.isDown("left")  or love.keyboard.isDown("a") then
		if player.inair == false then
			player.body:applyForce(-player.speed, 0)
		elseif player.inair == true then
			player.body:applyForce(-player.speed/3, 0)
		end
		if player.move.x <= -player.speed then
			player.body:setLinearVelocity(-player.speed, player.move.y)
		end
		player:setAnim("run left")
	end
	
	if love.keyboard.isDown("z") then
		camera:setScaleX(camera:getScaleX() + .01)
		camera:setScaleY(camera:getScaleY() + .01)
	end
	
	if love.keyboard.isDown("x") then
		camera:setScaleX(camera:getScaleX() - .01)
		camera:setScaleY(camera:getScaleY() - .01)
	end

	if love.keyboard.isDown("c") then
		camera:setRotation(camera:getRotation() + .01)
	end
	
	if love.keyboard.isDown("v") then
		camera:setRotation(camera:getRotation() - .01)
	end

end

function love.keypressed(k)
	if (k == " " or k == "w" or k == "up") and not player.inair then
		player.body:applyImpulse(0, -player.jump)
	end
end

function love.draw()	
	player:draw(camera:getX(),
	            camera:getY(),
	            camera:getRotation(), camera:getScaleX(), camera:getScaleY(), player.width, player.height)
	map:draw(camera:getX(), camera:getY(), camera:getRotation(), camera:getScaleX(), camera:getScaleY(), 0, 0)
	
	love.graphics.setBackgroundColor(80,120,200)
end
