if(!cooldown)
{
	if (instance_exists(global.currentPlayer))
	{
		if(knifeOut)
		{
			show_debug_message("attacking")
			global.currentPlayer.attacking = true
			radius = 20
			centerX = global.currentPlayer.x
			centerY = global.currentPlayer.y
			currentDirection = point_direction(centerX, centerY, mouse_x, mouse_y)
			slash = instance_create_layer(centerX + lengthdir_x(radius, currentDirection), centerY + lengthdir_y(radius, currentDirection), "Instances", obj_Dagger_Slash)
			slash.image_xscale = 1/4
			slash.image_yscale = 1/4
			cooldown = true
			alarm[0] = 36
		}
		else if(global.currentPlayer.object_index == obj_Rat_Enemy && !knifeOut)
		{
			global.currentPlayer.attacking = true
		}
		
	}
	
}