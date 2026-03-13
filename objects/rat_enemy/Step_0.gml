if(isPlayer)
{	
	event_inherited();
	var movement_x = key_right - key_left;
	var movement_y = key_down - key_up;
	if(movement_x > 0)
	{
		image_xscale = -.5
		sprite_index = rat_side
	}
	else if(movement_x < 0)
	{
		image_xscale = .5
		sprite_index = rat_side
	}
	else if(movement_y > 0)
	{
		image_xscale = .5
		sprite_index = rat_down
	}
	else if(movement_y < 0)
	{
		image_xscale = .5
		sprite_index = rat_side
	}
	else
	{
		image_xscale = .5
		sprite_index = rat_main
	}
}
else
{
	if(!attacking)
	{
		speed = 1.1
		if(!instance_exists(PlayerObject) || global.currentPlayer.hp <= 0)
		{
			game_restart()
		}
		else
		{
			direction = point_direction(x, y, global.currentPlayer.x, global.currentPlayer.y)
		}
		if(lengthdir_x(direction, direction) > 0)
		{
			image_xscale = -.5
			sprite_index = rat_side
		}
		else
		{
			image_xscale = .5
			sprite_index = rat_side
		}
	}
	if(distance_to_object(global.currentPlayer) < 15 || attacking)
	{
		attacking = true
		sprite_index = rat_attack
		frame_attack += 1
		show_debug_message(frame_attack)
		if(frame_attack < 30)
		{
			speed = 0
		}
		else if(frame_attack >= 30 && frame_attack < 45)
		{
			speed = 3
		}
		else if(frame_attack > 45 && frame_attack < 75)
		{
			speed = 0
			frame_attack = 0
		}
		else
		{
			attacking = false
			frame_attack = 0
		}
	}
}
if(hp <= 0) {
	alarm[0] = 1;
}


