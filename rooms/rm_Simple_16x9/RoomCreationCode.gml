//room_instance_add(simple16x9, 0,0,door);
//does create a door but it doesnt snapp to the damn grid
// 0: top
// 1: bottom
// 2. left
// 3. right
instance_create_layer(5*32 - 16, 0, "Instances", obj_Door, {
	loc_name: 0,
	});
bottomDoor = instance_create_layer(6*32 - 16, 6 * 32, "Instances", obj_Door, {
	loc_name: 1,
	});
bottomDoor.image_angle = 180
leftDoor = instance_create_layer(16, 3*32 + 16, "Instances", obj_Door, {
	loc_name: 2,
	});
leftDoor.image_angle = 90
rightDoor = instance_create_layer(9*32 + 16, 2*32 + 16,"Instances", obj_Door, {
	loc_name: 3,
	});
rightDoor.image_angle = 270
