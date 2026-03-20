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
		if !place_meeting(x + sign(tx - x), y, o_solid) x += sign(tx - x)
	}
	repeat(disy)
	{
		if !place_meeting(x, y + sign(ty - y), o_solid) y += sign(ty - y)
	}
}