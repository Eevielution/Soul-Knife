if (isPlayer) {
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
			exit;
		}
		exit;
	}

	if (state == TERMITESTATE.FREE) {
		// Normal WASD movement (doors handled by Collision_obj_Termite_Enemy on obj_Door)
		event_inherited();

		// ── Directional sprite (player-termite) ──────────────────────────────
		if (hsp > 0) {
			image_xscale = 0.5;  image_yscale = 0.5; sprite_index = spr_Termite_Side;
		} else if (hsp < 0) {
			image_xscale = -0.5; image_yscale = 0.5; sprite_index = spr_Termite_Side;
		} else if (vsp > 0) {
			image_xscale = 0.5;  image_yscale = 0.5; sprite_index = spr_Termite_Down;
		} else if (vsp < 0) {
			// Moving up — use main sprite to avoid an upside-down flip
			image_xscale = 0.5;  image_yscale = 0.5; sprite_index = spr_Termite_Main;
		} else {
			image_xscale = 0.5;  image_yscale = 0.5; sprite_index = spr_Termite_Main;
		}
	} else {
		// Dash attack — run the state machine so the lunge actually moves
		switch (state) {
			case TERMITESTATE.ATTACK_DASH:
				TermiteState_Attack_Dash();
				// Attack sprite during lunge; flip based on dash direction
				sprite_index = spr_Termite_Attack;
				image_xscale = (dash_direction == 180) ? -0.5 : 0.5;
				image_yscale = 0.5;
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

// ── Directional sprite (enemy termite) ───────────────────────────────────────
if (state == TERMITESTATE.ATTACK_DASH) {
	sprite_index = spr_Termite_Attack;
	image_xscale = (dash_direction == 180) ? -0.5 : 0.5;
	image_yscale = 0.5;
} else {
	// Use built-in hspeed/vspeed which reflect speed+direction
	if (abs(hspeed) >= abs(vspeed)) {
		sprite_index = spr_Termite_Side;
		image_xscale = (hspeed < 0) ? -0.5 : 0.5;
		image_yscale = 0.5;
	} else if (vspeed > 0) {
		sprite_index = spr_Termite_Down;
		image_xscale = 0.5; image_yscale = 0.5;
	} else {
		// Moving up — use main sprite; no vertical flip
		sprite_index = spr_Termite_Main;
		image_xscale = 0.5; image_yscale = 0.5;
	}
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
