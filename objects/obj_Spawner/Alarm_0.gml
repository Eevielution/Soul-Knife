// Determine room size to pick spawn pattern
var is_big_room = (room == rm_18x32 or room == rm_L or room == rm_TestRoom2);

// Spread offset so enemies don't stack — each enemy gets a quadrant of the spawner area
var _half_w = sprite_width  * 0.5;
var _half_h = sprite_height * 0.5;
var _safe   = 64; // minimum distance from any wall

// Enemy 1: top-left quadrant of the spawn area
var spawnx  = clamp(x + random_range(-_half_w, 0), _safe, room_width  - _safe);
var spawny  = clamp(y + random_range(-_half_h, 0), _safe, room_height - _safe);
// Enemy 2: bottom-right quadrant (guaranteed separation)
var spawnx2 = clamp(x + random_range(0, _half_w),  _safe, room_width  - _safe);
var spawny2 = clamp(y + random_range(0, _half_h),  _safe, room_height - _safe);

// Safe-spawn helper: don't drop an enemy directly on top of the player
// Works regardless of player form (human, rat, or termite).
var _cp         = instance_exists(global.currentPlayer) ? global.currentPlayer : noone;
var _spawn_dist = 48; // minimum pixels between spawn point and player

if (is_big_room) {
    // Big room: pick one of three 2-enemy combos
    var combo = irandom(2); // 0=rat+rat, 1=termite+termite, 2=rat+termite
    var obj1 = (combo == 1) ? obj_Termite_Enemy : obj_Rat_Enemy;
    var obj2 = (combo == 0) ? obj_Rat_Enemy : obj_Termite_Enemy;

    if (_cp == noone || point_distance(spawnx,  spawny,  _cp.x, _cp.y) >= _spawn_dist) {
        instance_create_layer(spawnx,  spawny,  "Instances", obj1);
    }
    if (_cp == noone || point_distance(spawnx2, spawny2, _cp.x, _cp.y) >= _spawn_dist) {
        instance_create_layer(spawnx2, spawny2, "Instances", obj2);
    }
} else {
    // Small room: spawn 1 enemy — rat or termite
    var obj = (irandom(1) == 0) ? obj_Rat_Enemy : obj_Termite_Enemy;
    if (_cp == noone || point_distance(spawnx, spawny, _cp.x, _cp.y) >= _spawn_dist) {
        instance_create_layer(spawnx, spawny, "Instances", obj);
    }
}

waiting_for_death = true;