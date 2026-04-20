// Define collision() here so it exists on the instance before any Collision event fires.
// (Defining it in End Step meant new instances could get a Collision event before End Step ran.)
function collision() {
	var tx = x
	var ty = y
	x = xprevious
	y = yprevious
	var disx = abs(tx - x)
	var disy = abs(ty - y)
	repeat(disx)
	{
		if place_meeting(x + sign(tx - x), y, obj_Door) { x = tx; break; }
		if collision_point(x + sign(tx - x), y, obj_Solid, false, true) break;
		var _rock_h = collision_point(x + sign(tx - x), y, obj_Rock, false, true);
		if (_rock_h != noone && !_rock_h.destroyed) break;
		x += sign(tx - x)
	}
	repeat(disy)
	{
		if place_meeting(x, y + sign(ty - y), obj_Door) { y = ty; break; }
		if collision_point(x, y + sign(ty - y), obj_Solid, false, true) break;
		var _rock_v = collision_point(x, y + sign(ty - y), obj_Rock, false, true);
		if (_rock_v != noone && !_rock_v.destroyed) break;
		y += sign(ty - y)
	}
}
