if(isPlayer)
{	
	event_inherited();
}
else
{
	hspeed = hsp
	vspeed = vsp
	timer += 1
	if(timer > timerStop)
	{
		hsp *= -1
		vsp *= -1
		timer = 0
	}
	// enemy tracking player
	// mp_linear_step(movementParent.x, movementParent.y, 0.5, 1); // current breaks game
}
if(hp <= 0) {
	alarm[0] = 1;
	
}


