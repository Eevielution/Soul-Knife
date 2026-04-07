// Creates spawn location
var spawnx = x + random_range(-sprite_width/2,sprite_width/2);
var spawny = y + random_range(-sprite_height/2,sprite_height/2);

// Checks if spawn conditions collides with player or another enemy
if !place_meeting(spawnx,spawny,obj_Player) && !place_meeting(spawnx,spawny,obj_Rat_Enemy) {
    instance_create_layer(spawnx,spawny,"Instances",obj_Rat_Enemy)
}

alarm[0] = random_range(180,600);