
if (instance_exists(global.currentPlayer)){
	// this radius should work for most sprites, if we keep them square / rectangular. change if needed
	radius = 0
	
	x = global.currentPlayer.x
	y = global.currentPlayer.y

	currentDirection = point_direction(x, y, mouse_x, mouse_y);

direction=global.currentPlayer.direction+90

image_angle = currentDirection - 90; 
}
else {
	instance_destroy(PlayerObject); 
} 



