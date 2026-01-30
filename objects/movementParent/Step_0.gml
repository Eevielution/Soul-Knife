// Checking Input Keys
key_left = keyboard_check(vk_left)
key_right = keyboard_check(vk_right)
key_up = keyboard_check(vk_up)
key_down = keyboard_check(vk_down)

// Constant Related to Physics
var movement_acceleration = 0.4;
var maximum_speed = 3;
var movement_friction = 0.25;

var movement_x = key_right - key_left;
var movement_y = key_down - key_up;

if (movement_x != 0) {
	hsp += movement_x * movement_acceleration;
	hsp = clamp(hsp, -maximum_speed, maximum_speed);
} else {
	if (abs(hsp) <= movement_friction) {
		hsp = 0;
	} else {
		hsp -= sign(hsp) * movement_friction;
	}
}
if (movement_y != 0) {
	vsp += movement_y * movement_acceleration;
	vsp = clamp(vsp, -maximum_speed, maximum_speed);
} else {
	if (abs(vsp) <= movement_friction) {
		vsp = 0;
	} else {
		vsp -= sign(vsp) * movement_friction;
	}
}

hspeed = hsp;
vspeed = vsp;