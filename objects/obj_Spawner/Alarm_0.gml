// Spawn an enemy near this spawner
var spawnx = x + random_range(-sprite_width * 0.5, sprite_width * 0.5);
var spawny = y + random_range(-sprite_height * 0.5, sprite_height * 0.5);

if (!place_meeting(spawnx, spawny, obj_Player) && !place_meeting(spawnx, spawny, obj_Rat_Enemy)) {
    instance_create_layer(spawnx, spawny, "Instances", obj_Rat_Enemy);
}

// Now watch for that enemy to die before scheduling the next spawn
waiting_for_death = true;