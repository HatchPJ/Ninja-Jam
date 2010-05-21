player = { }
player.left_image  = love.graphics.newImage("images/player/playerl.gif")
player.right_image = love.graphics.newImage("images/player/playerr.gif")

player.left_anim_image  = love.graphics.newImage("images/player/runl.gif")
player.right_anim_image = love.graphics.newImage("images/player/runr.gif")
player.stationary_left_anim  = newAnimation(player.left_image,  32, 32, 0.1, 0)
player.stationary_right_anim = newAnimation(player.right_image, 32, 32, 0.1, 0)
player.left_anim  = newAnimation(player.left_anim_image, 32, 32, 0.1, 0)
player.right_anim = newAnimation(player.right_anim_image, 32, 32, 0.1, 0)

player.image = player.stationary_right_anim

player.x = 0
player.y = 0
player.move = {}
player.move.x = 0
player.move.y = 0
player.speed = 200
player.jump = 30
player.grav = 0
player.inair = false