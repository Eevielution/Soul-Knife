function TermiteState_Free(){
	show_debug_message("termite free")
	speed = 0.8
	direction = point_direction(x, y, global.currentPlayer.x, global.currentPlayer.y)
	beforeAttack_x = x
	beforeAttack_y = y
	if (point_distance(x, y, global.currentPlayer.x, global.currentPlayer.y) < 40) {

		// dash vertically
		if (x >= global.currentPlayer.x - 16 and x < global.currentPlayer.x + 16) {
			dash_flag = true;
			if (y > global.currentPlayer.y) dash_direction = 90;
			else dash_direction = 270;
			state = TERMITESTATE.ATTACK_DASH;
		}
		// dash horizontally
		if (y >= global.currentPlayer.y - 16 and y < global.currentPlayer.y + 16) {
			dash_flag = true;
			if (x > global.currentPlayer.x) dash_direction = 180;
			else dash_direction = 0;
			state = TERMITESTATE.ATTACK_DASH;
		}
	}
}