if(!cooldown)
{
	if (instance_exists(global.currentPlayer))
	{
		if(knifeOut)
		{
			show_debug_message("attacking")
			global.currentPlayer.attacking = true
			// Random slash sound
			var _slash_sounds = [snd_slash1, snd_slash2, snd_slash3];
			audio_play_sound(_slash_sounds[irandom(2)], 1, false);
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
			audio_play_sound(snd_enemy_attack, 1, false);
			global.currentPlayer.attacking = true
		}
		
	}
	
}