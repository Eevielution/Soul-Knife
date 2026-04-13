if(isPlayer)
{	
	event_inherited();
	var movement_x = key_right - key_left
	var movement_y = key_down - key_up
	if(attacking && !PlayerObject.knifeOut)
	{

		movement_x = 0
		movement_y = 0
		sprite_index = rat_attack
		
		if(frame_attack = 0)
		{
			image_index = 0
			attack_angle = point_direction(x, y, mouse_x, mouse_y)
		}
		if(lengthdir_x(attack_angle, attack_angle) > 0)
		{
			image_xscale = -.5
		}
		else
		{
			image_xscale = .5
		}
		frame_attack += 1
		if(frame_attack < 20)
		{
			speed = 0
		}
		else if(frame_attack >= 20 && frame_attack < 50)
		{
			speed = 2
			direction = attack_angle
		}
		else if(frame_attack >= 50 && frame_attack < 70)
		{
			speed = 0
		}
		else if(frame_attack >= 70)
		{
			attacking = false
			frame_attack = 0
			image_index = 0
		}
		else
		{
			attacking = false
			frame_attack = 0
			image_index = 0
		}
	}
	else if(movement_x > 0)
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
if(hp <= 0 && PlayerObject.knifeOut)
{
	alarm[0] = 1
}
else if(hp <= 0 && !PlayerObject.knifeOut)
{
	instance_destroy()
}


