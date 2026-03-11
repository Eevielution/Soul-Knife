
/*
if (instance_exists(global.currentPlayer)){
	// this radius should work for most sprites, if we keep them square / rectangular. change if needed
	radius = 30
	
	centerX = global.currentPlayer.x + global.currentPlayer.sprite_width / 2
	centerY = global.currentPlayer.y + global.currentPlayer.sprite_height / 2

 currentDirection = point_direction(centerX, centerY, mouse_x, mouse_y);

instance_create_layer(centerX + lengthdir_x(radius, currentDirection), centerY + lengthdir_y(radius, currentDirection), Instances, DaggerSlashObject);
}
x = centerX + lengthdir_x(radius, currentDirection);
y = centerY + lengthdir_y(radius, currentDirection);
direction = global.currentPlayer.direction + 90

image_angle = currentDirection - 90; 

}
else {
	instance_destroy(PlayerObject); 
}
*/