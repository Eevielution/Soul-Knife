/// @description On room start, place player at entry door and remove it (no going back)
if (global.entry_door_side == -1) exit; // First room or non-door transition

var entry_door = noone;
with (obj_Door) {
    if (loc_name == global.entry_door_side) {
        entry_door = id;
    }
}

if (entry_door != noone) {
    x = entry_door.x;
    y = entry_door.y;

    // Push the player 48px inward so they aren't clipping the wall
    switch (global.entry_door_side) {
        case 0: y += 48; break; // entered via top wall, push down
        case 1: y -= 48; break; // entered via bottom wall, push up
        case 2: x += 48; break; // entered via left wall, push right
        case 3: x -= 48; break; // entered via right wall, push left
    }

    instance_destroy(entry_door);
}

// Reset so we don't re-run this on the next non-door room load
global.entry_door_side = -1;
