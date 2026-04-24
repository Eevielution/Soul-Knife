for (i = 0; i <= 360; i += 45)
{
	instance_create_layer(x + lengthdir_x(40, i), y + lengthdir_y(40, i), "Instances", obj_Miniroach_Enemy)
}
alarm[1] = 300