require("classes/Actor.lua")

player = Actor:new()

player:addAnim("idle left",  "images/player/playerl.gif", 32,32,0.1,0)
player:addAnim("idle right", "images/player/playerr.gif", 32,32,0.1,0)
player:addAnim("run left",   "images/player/runl.gif",    32,32,0.1,0)
player:addAnim("run right",  "images/player/runr.gif",    32,32,0.1,0)

player:setAnim("idle left")

player.x = 0
player.y = 0
player.width = 13
player.height = 19
player.move = {}
player.move.x = 0
player.move.y = 0
player.speed = 200
player.jump = 30
player.grav = 0
player.inair = false

--[[
function player:draw(x, y, angle, sx, sy, ox, oy)
	
	-- rotation: x=x*cos(r) - y*sin(r), y=x*sin(r) + y*cos(r) 
	final_x = ( (player.x * math.cos(angle)) -
				(player.y * math.sin(angle)) )
	final_y = ( (player.x * math.sin(angle)) +
				(player.y * math.cos(angle)) )
	
	-- scale
	final_x = final_x * sx
	final_y = final_y * sy
	
	-- position offset
	final_x = final_x + x
	final_y = final_y + y
	
	player.image:draw(final_x, final_y, angle, sx, sy, ox, oy)
end
--]]
