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
}