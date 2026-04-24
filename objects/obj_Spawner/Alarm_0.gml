// Determine room size
var is_big_room = (room == rm_18x32 or room == rm_L or room == rm_TestRoom2);

var _half_w = sprite_width  * 0.5;
var _half_h = sprite_height * 0.5;
var _safe   = 64;

// Spawn positions
var spawnx  = clamp(x + random_range(-_half_w, 0), _safe, room_width  - _safe);
var spawny  = clamp(y + random_range(-_half_h, 0), _safe, room_height - _safe);

var spawnx2 = clamp(x + random_range(0, _half_w),  _safe, room_width  - _safe);
var spawny2 = clamp(y + random_range(0, _half_h),  _safe, room_height - _safe);

// Player safety
var _cp = instance_exists(global.currentPlayer) ? global.currentPlayer : noone;
var _spawn_dist = 48;

// Wall safety
var _tries;

var _valid1 = false;
_tries = 0;
while (_tries < 20) {
    if (collision_circle(spawnx, spawny, 20, obj_Solid, false, true) == noone) { _valid1 = true; break; }
    spawnx = clamp(x + random_range(-_half_w, _half_w), _safe, room_width  - _safe);
    spawny = clamp(y + random_range(-_half_h, _half_h), _safe, room_height - _safe);
    _tries++;
}

var _valid2 = false;
_tries = 0;
while (_tries < 20) {
    if (collision_circle(spawnx2, spawny2, 20, obj_Solid, false, true) == noone) { _valid2 = true; break; }
    spawnx2 = clamp(x + random_range(-_half_w, _half_w), _safe, room_width  - _safe);
    spawny2 = clamp(y + random_range(-_half_h, _half_h), _safe, room_height - _safe);
    _tries++;
}

// ── Spawning ─────────────────────────────────────────────────────────
if (is_big_room) {

    var combos = [
        [obj_Rat_Enemy,     obj_Rat_Enemy],
        [obj_Termite_Enemy, obj_Termite_Enemy],
        [obj_Rat_Enemy,     obj_Termite_Enemy],
        [obj_Rat_Enemy,     obj_Roach_Enemy],
        [obj_Termite_Enemy, obj_Roach_Enemy]
    ];

    var pick = combos[irandom(array_length(combos) - 1)];

    if (_valid1 && (_cp == noone || point_distance(spawnx, spawny, _cp.x, _cp.y) >= _spawn_dist)) {
        instance_create_layer(spawnx, spawny, "Instances", pick[0]);
    }

    if (_valid2 && (_cp == noone || point_distance(spawnx2, spawny2, _cp.x, _cp.y) >= _spawn_dist)) {
        instance_create_layer(spawnx2, spawny2, "Instances", pick[1]);
    }

} else {

    var obj = enemy_types[irandom(array_length(enemy_types) - 1)];

    if (_valid1 && (_cp == noone || point_distance(spawnx, spawny, _cp.x, _cp.y) >= _spawn_dist)) {
        instance_create_layer(spawnx, spawny, "Instances", obj);
    }
}

waiting_for_death = true;