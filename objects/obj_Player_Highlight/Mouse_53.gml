if(!cooldown)
{
	if (instance_exists(global.currentPlayer))
	{
		if(knifeOut)
		{
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
			if (!global.currentPlayer.attacking) {
				audio_play_sound(snd_enemy_attack, 1, false);
				global.currentPlayer.attacking = true
			}
		}
		else if (global.currentPlayer.object_index == obj_Termite_Enemy && !knifeOut)
		{
			// Only start a new dash if currently idle (FREE state)
			if (global.currentPlayer.state == TERMITESTATE.FREE) {
				// Snap mouse angle to nearest cardinal direction
				var _angle = point_direction(global.currentPlayer.x, global.currentPlayer.y, mouse_x, mouse_y);
				var _dash_dir;
				if (_angle >= 315 || _angle < 45)       _dash_dir = 0;   // right
				else if (_angle >= 45  && _angle < 135) _dash_dir = 90;  // up
				else if (_angle >= 135 && _angle < 225) _dash_dir = 180; // left
				else                                     _dash_dir = 270; // down

				global.currentPlayer.dash_direction  = _dash_dir;
				global.currentPlayer.beforeAttack_x  = global.currentPlayer.x;
				global.currentPlayer.beforeAttack_y  = global.currentPlayer.y;
				global.currentPlayer.hspeed = 0;
				global.currentPlayer.vspeed = 0;
				global.currentPlayer.state = TERMITESTATE.ATTACK_DASH;
				audio_play_sound(snd_enemy_attack, 1, false);
			}
		}
		
	}
	
}