function TermiteState_Free(){
	var dist = point_distance(x, y, global.currentPlayer.x, global.currentPlayer.y);
	
	if (dist > 120) {
		// Keep closing the gap
		speed = 0.5;
		direction = point_direction(x, y, global.currentPlayer.x, global.currentPlayer.y);
	} else {
		// Inside attack zone — creep toward player while hunting for grid alignment
		speed = 0.3;
		direction = point_direction(x, y, global.currentPlayer.x, global.currentPlayer.y);
		
		var align = 20; // px tolerance for alignment check
		
		// Vertical dash: termite is in the same column as the player
		if (abs(x - global.currentPlayer.x) < align) {
			speed = 0;
			x = global.currentPlayer.x; // snap to exact column for a clean grid line
			beforeAttack_x = x;
			beforeAttack_y = y;
			dash_flag = true;
			immunity = false; // always hittable at the start of a new dash
			dash_direction = (y > global.currentPlayer.y) ? 90 : 270;
			audio_play_sound(snd_enemy_attack, 1, false);
			state = TERMITESTATE.ATTACK_DASH;
		}
		// Horizontal dash: termite is in the same row as the player
		else if (abs(y - global.currentPlayer.y) < align) {
			speed = 0;
			y = global.currentPlayer.y; // snap to exact row for a clean grid line
			beforeAttack_x = x;
			beforeAttack_y = y;
			dash_flag = true;
			immunity = false; // always hittable at the start of a new dash
			dash_direction = (x > global.currentPlayer.x) ? 180 : 0;
			audio_play_sound(snd_enemy_attack, 1, false);
			state = TERMITESTATE.ATTACK_DASH;
		}
	}
}
