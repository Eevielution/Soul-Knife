function TermiteState_Attack_Dash(){
	show_debug_message("termite attack")
	dash_flag = false;
	direction = dash_direction
	speed += .11;
	dx = abs(beforeAttack_x - x);
	dy = abs(beforeAttack_y - y);
	
	if (point_distance(x, y, global.currentPlayer.x, global.currentPlayer.y) > 160) {state = TERMITESTATE.FREE;}
	else if (place_meeting(x, y, obj_Solid)) {state = TERMITESTATE.COLLIDE;}
	//else if (place_meeting(x, y, obj_Player)) {state = TERMITESTATE.COLLIDE;}
	else if (dx > 80 or dy > 80) {state = TERMITESTATE.COLLIDE;}
	
}