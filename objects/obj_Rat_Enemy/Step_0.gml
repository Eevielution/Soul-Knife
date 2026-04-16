if(isPlayer)
{	
	event_inherited();

	// Door proximity check — typed collision unreliable with small scaled mask
	with (obj_Door) {
		if (point_distance(other.x, other.y, x, y) < 10) {
			// trigger the same transition as Collision_obj_Rat_Enemy
			var opp_sides = [1, 0, 3, 2];
			global.entry_door_side = opp_sides[loc_name];
			var candidates;
			switch (global.entry_door_side) {
				case 0: candidates = [rm_16x9, rm_16x18, rm_18x32]; break;
				case 1: candidates = [rm_16x9, rm_16x18, rm_18x32, rm_L]; break;
				case 2: candidates = [rm_16x9, rm_16x18, rm_18x32]; break;
				case 3: candidates = [rm_16x9, rm_16x18, rm_18x32, rm_L]; break;
			}
			global.player_hp = global.currentPlayer.hp;
			room_goto(candidates[irandom(array_length(candidates) - 1)]);
			break;
		}
	}

	var movement_x = key_right - key_left
	var movement_y = key_down - key_up
	if(attacking && !obj_Player_Highlight.knifeOut)
	{

		movement_x = 0
		movement_y = 0
		sprite_index = spr_Rat_Attack
		
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
		image_yscale = .5
		sprite_index = spr_Rat_Side
	}
	else if(movement_x < 0)
	{
		image_xscale = .5
		image_yscale = .5
		sprite_index = spr_Rat_Side
	}
	else if(movement_y > 0)
	{
		image_xscale = .5
		image_yscale = .5
		sprite_index = spr_Rat_Down
	}
	else if(movement_y < 0)
	{
		image_xscale = .5
		image_yscale = .5
		sprite_index = spr_Rat_Side
	}
	else
	{
		image_xscale = .5
		image_yscale = .5
		sprite_index = spr_Rat_Main
	}

}
else
{
	if(!attacking)
	{
		speed = 1.1
		if(!instance_exists(obj_Player_Highlight) || global.currentPlayer.hp <= 0)
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
			image_yscale = .5
			sprite_index = spr_Rat_Side
		}
		else
		{
			image_xscale = .5
			image_yscale = .5
			sprite_index = spr_Rat_Side
		}
	}
	{
		attacking = true
		sprite_index = spr_Rat_Attack
		frame_attack += 1
		if (frame_attack == 1) audio_play_sound(snd_enemy_attack, 1, false);
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
if(hp <= 0 && obj_Player_Highlight.knifeOut)
{
    // Enemy rat dies — just destroy it, do NOT transform
    if (!isPlayer) {
        // Heal the player on kill
        audio_play_sound(snd_kill, 1, false);
        global.currentPlayer.hp = min(global.currentPlayer.hp + 10, global.currentPlayer.max_hp);
        instance_destroy();
    }
}
else if(hp <= 0 && !obj_Player_Highlight.knifeOut)
{
    if (!isPlayer) {
        audio_play_sound(snd_kill, 1, false);
        instance_destroy();
    }
}

// Bleed — only drains when this rat IS the player
if (isPlayer) {
    hp -= bleed_rate;
    hp = max(hp, 0);
    if (hp <= 0) {
        // Rat body is spent — revert to human instead of dying
        var _rx = x;
        var _ry = y;
        global.player_hp = global.human_hp;
        obj_Player_Highlight.knifeOut = true; // restore knife for human form
        isPlayer = false;
        persistent = false;
        instance_create_layer(_rx, _ry, "Instances", obj_Player);
        instance_destroy();
    }
}


