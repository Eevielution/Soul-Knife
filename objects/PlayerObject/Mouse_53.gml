if (instance_exists(global.currentPlayer)){
	radius = 100
	
	centerX = global.currentPlayer.x
	centerY = global.currentPlayer.y
	currentDirection = point_direction(centerX, centerY, mouse_x, mouse_y);

instance_create_layer(centerX + lengthdir_x(radius, currentDirection), centerY + lengthdir_y(radius, currentDirection), "Instances", DaggerSlashObject);
}