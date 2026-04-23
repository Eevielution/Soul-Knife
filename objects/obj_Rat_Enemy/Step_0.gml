if(isPlayer)
{	
	// Block all input during a room transition
	if (instance_exists(obj_Transition)) {
		hp -= bleed_rate;
		hp = max(hp, 0);
		if (hp <= 0) {
			var _rx = x;
			var _ry = y;
			global.player_hp = global.human_hp;
			obj_Player_Highlight.knifeOut = true;
			isPlayer = false;
			persistent = false;
			instance_create_layer(_rx, _ry, "Instances", obj_Player);
			instance_destroy();
		}
		exit;
	}

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
			if (!instance_exists(obj_Transition)) {
				global.transition_room = candidates[irandom(array_length(candidates) - 1)];
				instance_create_layer(0, 0, "Instances", obj_Transition);
			}
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
		if(lengthdir_x(1, attack_angle) > 0)
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
		// Moving up — use the neutral sprite to avoid an upside-down flip
		image_xscale = .5
		image_yscale = .5
		sprite_index = spr_Rat_Main
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
			game_restart();
			exit;
		}
		else
		{
			direction = point_direction(x, y, global.currentPlayer.x, global.currentPlayer.y)
		}
		if(lengthdir_x(1, direction) > 0)
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
        audio_play_sound(snd_kill, 1, false);
        // Heal: if player is transformed, heal the paused human HP (not the animal)
        // If player is human, heal currentPlayer directly
        var _cp = global.currentPlayer;
        if (_cp.object_index == obj_Rat_Enemy || _cp.object_index == obj_Termite_Enemy) {
            global.human_hp = min(global.human_hp + 10, 50);
        } else {
            _cp.hp = min(_cp.hp + 10, _cp.max_hp);
        }
        global.creatures_slain++;
        instance_destroy();
    }
}
else if(hp <= 0 && !obj_Player_Highlight.knifeOut)
{
    if (!isPlayer) {
        audio_play_sound(snd_kill, 1, false);
        var _cp = global.currentPlayer;
        if (_cp.object_index == obj_Rat_Enemy || _cp.object_index == obj_Termite_Enemy) {
            global.human_hp = min(global.human_hp + 10, 50);
        } else {
            _cp.hp = min(_cp.hp + 10, _cp.max_hp);
        }
        global.creatures_slain++;
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


