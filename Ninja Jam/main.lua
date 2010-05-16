SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 600
require("lib/AnAL.lua")

objects = {}

background = { }
	background.image = love.graphics.newImage("images/bg.gif")
	background.x = 0
	background.y = 0

ground = { }
	ground.image = love.graphics.newImage("images/ground.gif")
	ground.x = 0
	ground.y = SCREEN_HEIGHT - ground.image:getHeight()

player = { }
	player.left_image  = love.graphics.newImage("images/player/playerl.gif")
	player.right_image = love.graphics.newImage("images/player/playerr.gif")
	
	player.left_anim_image  = love.graphics.newImage("images/player/runl.gif")
	player.right_anim_image = love.graphics.newImage("images/player/runr.gif")
	player.stationary_left_anim  = newAnimation(player.left_image,  32, 32, 0.1, 0)
	player.stationary_right_anim = newAnimation(player.right_image, 32, 32, 0.1, 0)
	player.left_anim  = newAnimation(player.left_anim_image, 28, 28, 0.1, 0)
	player.right_anim = newAnimation(player.right_anim_image, 28, 28, 0.1, 0)
	
	player.image = player.stationary_left_anim
	
	player.x = 2
	player.y = SCREEN_HEIGHT - ground.image:getHeight() - player.image:getHeight()
	player.move = {}
	player.move.x = 0
	player.move.y = 0
	player.speed = 300
	player.grav = 0
	player.inair = 0

grav = 200

function love.load()
	world = love.physics.newWorld(SCREEN_WIDTH, SCREEN_HEIGHT)
	world:setGravity(0, 700)
	world:setMeter(64)
	
	bodies = {}
	shapes = {}
	
	bodies[0] = love.physics.newBody(world, SCREEN_WIDTH/2, SCREEN_HEIGHT - 25, 0, 0)
	shapes[0] = love.physics.newRectangleShape(bodies[0], 0, 0, SCREEN_WIDTH, 50, 0)
	
	bodies[1] = love.physics.newBody(world, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 5, 0)
	shapes[1] = love.physics.newRectangleShape(bodies[1], 0, 0, player.image:getHeight(), player.image:getWidth(), 0)
	
	love.graphics.setMode( SCREEN_WIDTH, SCREEN_HEIGHT, false, true, 0 )
end

function love.update(dt)
	player.left_anim_image:setFilter("nearest", "nearest")
	player.right_anim_image:setFilter("nearest", "nearest")
	player.left_image:setFilter("nearest", "nearest")
	player.right_image:setFilter("nearest", "nearest")
	world:update(dt)
	player.image:update(dt)
	
	mvx, mvy = bodies[1]:getLinearVelocity()
	px, py = bodies[1]:getPosition()
	
	if mvx < 10 and mvx > -10 then
		if player.image == player.left_anim then
			player.image = player.stationary_left_anim
		elseif player.image == player.right_anim then
			player.image = player.stationary_right_anim
		end
	end
	
	gy = SCREEN_HEIGHT - 50
	pyb = py + player.image:getHeight()/2
	
	if pyb < gy + 3 and pyb > gy - 3 then
		player.inair = 0
	else
		player.inair = 1
	end

	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		bodies[1]:applyForce(200, 0)
		if mvx >= 300 then
			bodies[1]:setLinearVelocity(300, mvy)
		end
		player.image = player.right_anim
	end
	
	if love.keyboard.isDown("left")  or love.keyboard.isDown("a") then
		bodies[1]:applyForce(-200, 0)
		if mvx <= -300 then
			bodies[1]:setLinearVelocity(-300, mvy)
		end
		player.image = player.left_anim
	end
	
end

function love.keypressed(k)
	if k == " " or k == "w" or k == "up" and player.inair == 0 then
		bodies[1]:applyImpulse(0, -40)
	end
end

function love.draw()
	love.graphics.draw(background.image, background.x, background.y)
	
	local x1, y1, x2, y2, x3, y3, x4, y4 = shapes[0]:getBoundingBox()
	local boxwidth = x3 - x2
	local boxheight = y2 - y1
	love.graphics.setColor(72, 160, 14)
	love.graphics.rectangle("fill", bodies[0]:getX()  - boxwidth/2, bodies[0]:getY() - boxheight/2, boxwidth, boxheight)
	love.graphics.setColor(255, 255, 255)
	
	player.image:draw(bodies[1]:getX(), bodies[1]:getY())
	
	printx, printy = bodies[1]:getLinearVelocity()
	love.graphics.print(printx, 20, 40)
	love.graphics.print(printy, 20, 55)
	love.graphics.print(gy, 20, 70)
	love.graphics.print(pyb, 20, 85)
	love.graphics.print(love.mouse.getY(), 20, 100)
	love.graphics.print(player.inair, 20, 115)
end
