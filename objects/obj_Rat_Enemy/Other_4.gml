/// @description On room start, place player-rat at entry door (mirrors obj_Player/Other_4.gml)
if (!isPlayer) exit;

// Re-link camera to this persistent instance
if (instance_exists(obj_Camera)) {
    obj_Camera.follow_target = id;
}

if (global.entry_door_side == -1) exit;

var entry_door = noone;
with (obj_Door) {
    if (loc_name == global.entry_door_side) {
        entry_door = id;
        break;
    }
}

if (entry_door != noone) {
    x = entry_door.x;
    y = entry_door.y;

    switch (global.entry_door_side) {
        case 0: y += 48; break; // entered via top wall, push down
        case 1: y -= 48; break; // entered via bottom wall, push up
        case 2: x += 48; break; // entered via left wall, push right
        case 3: x -= 48; break; // entered via right wall, push left
    }

    instance_destroy(entry_door);
}

global.entry_door_side = -1;
