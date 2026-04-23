event_inherited();

// Block all player input and movement during a room transition
if (instance_exists(obj_Transition)) {
    if (hp <= 0) {
        audio_play_sound(snd_gameover, 1, false);
        room_goto(rm_Game_Over);
        exit;
    }
    hp -= bleed_rate;
    hp = max(hp, 0);
    exit;
}

var movement_x = key_right - key_left;
var movement_y = key_down - key_up;
if(attacking)
{
	movement_x = 0
	movement_y = 0
	if(frame_attack = 0)
	{
		attack_angle = point_direction(x, y, mouse_x, mouse_y)
		if(attack_angle >= 225 && attack_angle <= 315)
		{
			sprite_index = spr_Khile_Down_Slash
		}
		else if((attack_angle > 315 && attack_angle <= 360) || (attack_angle >= 0 && attack_angle < 45))
		{
			sprite_index = spr_Khile_Side_Slash
		}
		else if(attack_angle >= 45 && attack_angle <= 135)
		{
			sprite_index = spr_Khile_Up_Slash
		}
			else if(attack_angle > 135 && attack_angle < 225)
		{
			sprite_index = spr_Khile_Side_Slash
			image_xscale = -1
		}
		else
		{
			sprite_index = spr_Khile_Side_Stab
		}
		image_index = 0
	}
	if(frame_attack < 37)
	{
		speed = 0
		frame_attack += 1
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
	image_xscale = 1
	sprite_index = spr_Khile_Side
}
else if(movement_x < 0)
{
	image_xscale = -1
	sprite_index = spr_Khile_Side
}
else if(movement_y > 0)
{
	image_xscale = 1
	sprite_index = spr_Khile_Down
}
else if(movement_y < 0)
{
	image_xscale = 1
	sprite_index = spr_Khile_Up
}
else
{
	image_xscale = 1
	sprite_index = spr_Khile_Main
}

// Decay hit cooldown
if (hit_cooldown > 0) hit_cooldown -= 1;

if (hp <= 0) {
	audio_play_sound(snd_gameover, 1, false);
	room_goto(rm_Game_Over);
	exit;
}

// Bleed — constant HP drain
hp -= bleed_rate;
hp = max(hp, 0);
