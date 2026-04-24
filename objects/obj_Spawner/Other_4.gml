global.rooms_visited++;

// ── Boss spawn check ──────────────────────────────────────────────────────────
var _is_boss_eligible = (room == rm_18x32 || room == rm_16x18 || room == rm_Roach);

if (global.rooms_visited > 1 && _is_boss_eligible) {
    if (global.boss_countdown > 0) global.boss_countdown--;

    if (global.boss_countdown <= 0) {
        global.boss_countdown = irandom_range(5, 10);
        instance_create_layer(room_width * 0.5, room_height * 0.5, "Instances", obj_Centipede_Head);
        exit;
    }
}

// ── Spawn rocks ───────────────────────────────────────────────────────────────
var _num_rocks   = irandom_range(1, 3);
var _rock_margin = 96;

for (var _i = 0; _i < _num_rocks; _i++) {
    for (var _attempt = 0; _attempt < 30; _attempt++) {

        var _rx = random_range(_rock_margin, room_width  - _rock_margin);
        var _ry = random_range(_rock_margin, room_height - _rock_margin);

        if (collision_circle(_rx, _ry, 28, obj_Solid, false, true) != noone) continue;

        var _near_door = false;
        with (obj_Door) {
            if (point_distance(_rx, _ry, x, y) < 80) _near_door = true;
        }
        if (_near_door) continue;

        var _too_close = false;
        with (obj_Rock) {
            if (point_distance(_rx, _ry, x, y) < 64) { _too_close = true; break; }
        }
        if (_too_close) continue;

        if (instance_exists(global.currentPlayer) &&
            point_distance(_rx, _ry, global.currentPlayer.x, global.currentPlayer.y) < 64) continue;

        instance_create_layer(_rx, _ry, "Instances", obj_Rock);
        break;
    }
}

if (global.rooms_visited <= 1) exit;

// ── FIXED ENEMY COUNT ─────────────────────────────────────────────────────────
var _enemy_count = 0;

for (var i = 0; i < array_length(enemy_types); i++) {
    var _type = enemy_types[i];

    with (_type) {
        if (!isPlayer) _enemy_count++;
    }
}

// ─────────────────────────────────────────────────────────────────────────────

if (_enemy_count == 0) {
    alarm[0] = 1;
    waiting_for_death = false;
} else {
    waiting_for_death = true;
}