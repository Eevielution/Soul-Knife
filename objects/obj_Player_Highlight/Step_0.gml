
if (instance_exists(global.currentPlayer))
{
	playerX = global.currentPlayer.x
	playerY = global.currentPlayer.y
	if(point_distance(x, y, playerX, playerY) < 4)
	{
		x = playerX
		y = playerY
		speed = 0
	}
	else
	{
		speed = 2
		direction = point_direction(x, y, playerX, playerY)
	}
	image_angle = point_direction(x, y, mouse_x, mouse_y) - 90
}
else
{
	instance_destroy(obj_Player_Highlight); 
} 



