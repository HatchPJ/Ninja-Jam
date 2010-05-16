SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 600

objects = {}

background = { }
	background.image = love.graphics.newImage("bg.gif")
	background.x = 0
	background.y = 0

ground = { }
	ground.image = love.graphics.newImage("ground.gif")
	ground.x = 0
	ground.y = SCREEN_HEIGHT - ground.image:getHeight()

player = { }
	player.image       = love.graphics.newImage("playerr.gif")
	player.left_image  = love.graphics.newImage("playerl.gif")
	player.right_image = love.graphics.newImage("playerr.gif")
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
	
	bodies = {} --create tables for the bodies and shapes so that the garbage collector doesn't delete them
	shapes = {}
	
	bodies[0] = love.physics.newBody(world, SCREEN_WIDTH/2, SCREEN_HEIGHT - 25, 0, 0)
	shapes[0] = love.physics.newRectangleShape(bodies[0], 0, 0, SCREEN_WIDTH, 50, 0)
	
	bodies[1] = love.physics.newBody(world, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 5, 0)
	shapes[1] = love.physics.newRectangleShape(bodies[1], 0, 0, player.image:getHeight(), player.image:getWidth(), 0)
	
	love.graphics.setMode( SCREEN_WIDTH, SCREEN_HEIGHT, false, true, 0 )
end

function love.update(dt)
	world:update(dt)
	player.image:setFilter("nearest", "nearest")
	mvx, mvy = bodies[1]:getLinearVelocity()
	
	px, py = bodies[1]:getPosition()
	
	gy = SCREEN_HEIGHT - 50
	pyb = py + player.image:getHeight()/2
	
	if pyb < gy + 3 and pyb > gy - 3 then
		player.inair = 0
	else
		player.inair = 1
	end

	if love.keyboard.isDown("right") then
		bodies[1]:applyForce(200, 0)
		if mvx >= 300 then
			bodies[1]:setLinearVelocity(300, mvy)
		end
		player.image = player.right_image
	end
	if love.keyboard.isDown("left") then
		bodies[1]:applyForce(-200, 0)
		if mvx <= -300 then
			bodies[1]:setLinearVelocity(-300, mvy)
		end
		player.image = player.left_image
	end
	
end

function love.keypressed(k)
	if k == " " and player.inair == 0 then
		bodies[1]:applyImpulse(0, -40)
	end
end

function love.draw()
	love.graphics.draw(background.image, background.x, background.y)
	
	local x1, y1, x2, y2, x3, y3, x4, y4 = shapes[0]:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
	local boxwidth = x3 - x2 --calculate the width of the box
	local boxheight = y2 - y1 --calculate the height of the box
	love.graphics.setColor(72, 160, 14)
	love.graphics.rectangle("fill", bodies[0]:getX()  - boxwidth/2, bodies[0]:getY() - boxheight/2, boxwidth, boxheight)
	love.graphics.setColor(255, 255, 255)
	
	love.graphics.draw(player.image, bodies[1]:getX(), bodies[1]:getY())
	
	printx, printy = bodies[1]:getLinearVelocity()
	love.graphics.print(printx, 20, 40)
	love.graphics.print(printy, 20, 55)
	love.graphics.print(gy, 20, 70)
	love.graphics.print(pyb, 20, 85)
	love.graphics.print(love.mouse.getY(), 20, 100)
	love.graphics.print(player.inair, 20, 115)
end
