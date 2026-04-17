function TermiteState_Collide() {
	dash_flag = false
	speed = 0;
	timeToMove--;
	if (timeToMove <= 0) {
		state = TERMITESTATE.FREE;
		timeToMove = 50;
	}
}
