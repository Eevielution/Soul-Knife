if (isPlayer) {
	if (state == TERMITESTATE.FREE) {
		// Normal WASD movement (doors handled by Collision_obj_Termite_Enemy on obj_Door)
		event_inherited();

		// Sprite flip
		if (hsp < 0) image_xscale = -1;
		else if (hsp > 0) image_xscale = 1;
	} else {
		// Dash attack — run the state machine so the lunge actually moves
		switch (state) {
			case TERMITESTATE.ATTACK_DASH:
				TermiteState_Attack_Dash();
				// Skip the COLLIDE cooldown for the player — return to free movement immediately
				if (state == TERMITESTATE.COLLIDE) {
					state = TERMITESTATE.FREE;
					hspeed = 0; vspeed = 0;
					hsp = 0; vsp = 0;
				}
				break;
			case TERMITESTATE.COLLIDE:
				TermiteState_Collide();
				break;
		}
	}

	// Bleed — drains HP over time while player-controlled
	hp -= bleed_rate;
	hp = max(hp, 0);
	if (hp <= 0) {
		// Termite body spent — revert to human
		var _rx = x;
		var _ry = y;
		global.player_hp = global.human_hp;
		obj_Player_Highlight.knifeOut = true;
		isPlayer = false;
		persistent = false;
		instance_create_layer(_rx, _ry, "Instances", obj_Player);
		instance_destroy();
		exit;
	}

	exit; // skip enemy AI below
}

if (!instance_exists(obj_Player_Highlight) || global.currentPlayer.hp <= 0) {
	game_restart();
	exit;
}

switch (state) {
	case TERMITESTATE.FREE: TermiteState_Free(); break;
	case TERMITESTATE.ATTACK_DASH: TermiteState_Attack_Dash(); break;
	case TERMITESTATE.COLLIDE: TermiteState_Collide(); break;
}

if (hp <= 0) {
	audio_play_sound(snd_kill, 1, false);
	// Heal: if player is transformed, credit human HP; otherwise heal currentPlayer directly
	var _cp = global.currentPlayer;
	if (_cp.object_index == obj_Rat_Enemy || _cp.object_index == obj_Termite_Enemy) {
		global.human_hp = min(global.human_hp + 10, 50);
	} else {
		_cp.hp = min(_cp.hp + 10, _cp.max_hp);
	}
	global.creatures_slain++;
	instance_destroy();
	exit;
}
