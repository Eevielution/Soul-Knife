event_inherited();
//logic for swapping sprites depending on direction:
index = object_get_sprite(originalPlayer);
name = sprite_get_name(index);
//show_debug_message(name);
//get name of current spirte, parse it and then switch depending on direction
var movement_x = key_right - key_left;
var movement_y = key_down - key_up;
//if(abs(movement_x) > abs(movement_y) {
	//idk wtf key_right
	
//}

if (hp <= 0) {
	instance_destroy();
}
