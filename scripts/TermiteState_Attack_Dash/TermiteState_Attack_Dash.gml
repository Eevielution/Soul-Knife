function TermiteState_Attack_Dash(){
	dash_flag = false;
	
	// Accelerate along a pure cardinal axis — no diagonal drift
	var accel = 0.6;
	var max_spd = 7;
	if (dash_direction == 0)        { hspeed = min(hspeed + accel, max_spd);  vspeed = 0; }  // right
	else if (dash_direction == 180)  { hspeed = max(hspeed - accel, -max_spd); vspeed = 0; }  // left
	else if (dash_direction == 90)   { vspeed = max(vspeed - accel, -max_spd); hspeed = 0; }  // up   (negative vspeed in GML)
	else                             { vspeed = min(vspeed + accel, max_spd);  hspeed = 0; }  // 270 = down
	
	dx = abs(beforeAttack_x - x);
	dy = abs(beforeAttack_y - y);
	
	// Look one step ahead for walls
	var nx = x + hspeed;
	var ny = y + vspeed;
	
	if (point_distance(x, y, global.currentPlayer.x, global.currentPlayer.y) > 200) {
		hspeed = 0; vspeed = 0;
		state = TERMITESTATE.FREE;
	} else if (place_meeting(nx, ny, obj_Solid)) {
		hspeed = 0; vspeed = 0;
		state = TERMITESTATE.COLLIDE;
	} else {
		var _blocking_rock = instance_place(nx, ny, obj_Rock);
		if (_blocking_rock != noone && !_blocking_rock.destroyed) {
			hspeed = 0; vspeed = 0;
			state = TERMITESTATE.COLLIDE;
		}
	}
	
	if (dx > 160 or dy > 160) {
		hspeed = 0; vspeed = 0;
		state = TERMITESTATE.COLLIDE;
	}
}
