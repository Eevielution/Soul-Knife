// Checking Input Keys
key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))
key_up = keyboard_check(ord("W"))
key_down = keyboard_check(ord("S"))

// Constant Related to Physics
// Subclasses can override move_accel / move_max_speed instance vars for faster forms
var movement_acceleration = variable_instance_exists(id, "move_accel") ? move_accel : 0.4
var maximum_speed = variable_instance_exists(id, "move_max_speed") ? move_max_speed : 1.5
var movement_friction = 0.25

var movement_x = key_right - key_left
var movement_y = key_down - key_up


// this is for fixing vectoring issue
var input_total = point_distance(0, 0, movement_x, movement_y)
if (input_total > 0)
{
    movement_x /= input_total
    movement_y /= input_total
}

if (movement_x != 0)
{
    hsp += movement_x * movement_acceleration
    hsp = clamp(hsp, -maximum_speed, maximum_speed)
} else
{
    if (abs(hsp) <= movement_friction)
	{
        hsp = 0;
    } 
	else
	{
        hsp -= sign(hsp) * movement_friction
    }
}
if (movement_y != 0)
{
    vsp += movement_y * movement_acceleration
    vsp = clamp(vsp, -maximum_speed, maximum_speed)
}
else
{
    if (abs(vsp) <= movement_friction)
	{
        vsp = 0
    }
	else
	{
        vsp -= sign(vsp) * movement_friction
    }
}
hspeed = hsp
vspeed = vsp
if(speed > maximum_speed)
{
	speed = maximum_speed
}

