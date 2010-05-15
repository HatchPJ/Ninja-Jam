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

grav = 200

function love.load()
	love.graphics.setMode( SCREEN_WIDTH, SCREEN_HEIGHT, false, true, 0 )
end

function love.update(dt)
	player.image:setFilter("nearest", "nearest")
	
	if love.keyboard.isDown("right") then
		player.x = player.x + (player.speed * dt)
		player.image = player.right_image
	elseif love.keyboard.isDown("left") then
		player.x = player.x - (player.speed * dt)
		player.image = player.left_image

	end
		
	if love.keyboard.isDown("down") then
--		player.y = player.y + (player.speed * dt)
	elseif love.keyboard.isDown("up") then
--		player.y = player.y - (player.speed * dt)
	end
end

function love.draw()
	love.graphics.draw(background.image, background.x, background.y)
	love.graphics.draw(ground.image, ground.x, ground.y)
	love.graphics.draw(player.image, player.x, player.y, 0, 2, 2)
	love.graphics.print("arrow keys move left and right", 20, 40)
end
