require("lib/AnAL.lua")
require("classes/Tile.lua")
require("classes/Map.lua")
require("player.lua")
require("maps/map1.lua")

SCALE_X = 2
SCALE_Y = 2
SCREEN_WIDTH  = 640
SCREEN_HEIGHT = 480

love.graphics.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, false, true, 0)

map = Map:new(8, 8, layers)

bodies = {love.physics.newBody(map.world, 0, 0, 5, 0)}
shapes = {love.physics.newRectangleShape(bodies[1], 0, 0, player.image:getHeight(), player.image:getWidth(), 0)}

function love.update(dt)
	map.world:update(dt)
	player.image:update(dt)
	
	player.move.x, player.move.y = bodies[1]:getLinearVelocity()
	player.x, player.y = bodies[1]:getPosition()
	
		if player.move.x < 10 and player.move.x > -10 then
		if player.image == player.left_anim then
			player.image = player.stationary_left_anim
		elseif player.image == player.right_anim then
			player.image = player.stationary_right_anim
		end
	end
	
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		if player.inair == false then
			bodies[1]:applyForce(player.speed, 0)
		elseif player.inair == true then
			bodies[1]:applyForce(player.speed/3, 0)
		end
		if player.move.x >= player.speed then
			bodies[1]:setLinearVelocity(player.speed, player.move.y)
		end
		player.image = player.right_anim
	end
	
	if love.keyboard.isDown("z") then
		SCALE_X = SCALE_X + .01
		SCALE_Y = SCALE_Y + .01
	end
	
	if love.keyboard.isDown("x") then
		SCALE_X = SCALE_X - .01
		SCALE_Y = SCALE_Y - .01
	end
	
	if love.keyboard.isDown("left")  or love.keyboard.isDown("a") then
		if player.inair == false then
			bodies[1]:applyForce(-player.speed, 0)
		elseif player.inair == true then
			bodies[1]:applyForce(-player.speed/3, 0)
		end
		if player.move.x <= -player.speed then
			bodies[1]:setLinearVelocity(-player.speed, player.move.y)
		end
		player.image = player.left_anim
	end
end

function love.keypressed(k)
	if (k == " " or k == "w" or k == "up") and not player.inair then
		bodies[1]:applyImpulse(0, -player.jump)
	end
end

function love.draw()
	player.image:draw(bodies[1]:getX() * SCALE_X, bodies[1]:getY() * SCALE_Y, 0, SCALE_X, SCALE_Y, 9.5, 13)
	map:draw(0, 0, 0, SCALE_X, SCALE_Y, 0, 0)
	
	love.graphics.setBackgroundColor(80,120,200)
end
