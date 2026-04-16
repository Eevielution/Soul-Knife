function TermiteState_Collide() {
	dash_flag = false
	speed = 0;
	show_debug_message("termite collide")
	timeToMove--;
	if (timeToMove <= 0) {
		show_debug_message("termite collide: times up!")
		state = TERMITESTATE.FREE;
		timeToMove = 50;
	}
}