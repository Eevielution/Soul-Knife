// Room Start — spawn immediately if no enemies exist anywhere in the room
// The very first room is always safe — don't spawn anything
global.rooms_visited++;

// ── Spawn rocks (1–3) in every room ─────────────────────────────────────────
var _num_rocks   = irandom_range(1, 3);
var _rock_margin = 96; // minimum distance from any wall edge
for (var _i = 0; _i < _num_rocks; _i++) {
    var _placed = false;
    for (var _attempt = 0; _attempt < 30; _attempt++) {
        var _rx = random_range(_rock_margin, room_width  - _rock_margin);
        var _ry = random_range(_rock_margin, room_height - _rock_margin);

        // Reject if point falls inside a wall tile
        if (collision_point(_rx, _ry, obj_Solid, false, true) != noone) continue;

        // Reject if too close to any door
        var _near_door = false;
        with (obj_Door) {
            if (point_distance(_rx, _ry, x, y) < 80) _near_door = true;
        }
        if (_near_door) continue;

        // Reject if too close to an already-placed rock
        var _too_close = false;
        with (obj_Rock) {
            if (point_distance(_rx, _ry, x, y) < 64) { _too_close = true; break; }
        }
        if (_too_close) continue;

        // Reject if on top of the player
        if (instance_exists(global.currentPlayer) &&
            point_distance(_rx, _ry, global.currentPlayer.x, global.currentPlayer.y) < 64) continue;

        instance_create_layer(_rx, _ry, "Instances", obj_Rock);
        _placed = true;
        break;
    }
}
// ────────────────────────────────────────────────────────────────────────────

if (global.rooms_visited <= 1) exit;

var _enemy_count = 0;
with (obj_Rat_Enemy) {
    if (!isPlayer) _enemy_count++;
}
with (obj_Termite_Enemy) {
    if (!isPlayer) _enemy_count++;
}

if (_enemy_count == 0) {
    // Spawn right now
    alarm[0] = 1;
    waiting_for_death = false;
} else {
    // Enemies already here — wait for them to die before taking over
    waiting_for_death = true;
}
