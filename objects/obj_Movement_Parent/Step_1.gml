//collisions
function collision() {
	var tx = x
	var ty = y
	x = xprevious
	y = yprevious
	var disx = abs(tx - x)
	var disy = abs(ty - y)
	repeat(disx)
	{
		if !place_meeting(x + sign(tx - x), y, obj_Solid) x += sign(tx - x)
	}
	repeat(disy)
	{
		if !place_meeting(x, y + sign(ty - y), obj_Solid) y += sign(ty - y)
	}
}