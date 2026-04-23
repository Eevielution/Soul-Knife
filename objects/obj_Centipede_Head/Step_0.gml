// ── Write current position into the history buffer before moving ─────────────
pos_history_x[@ history_head] = x;
pos_history_y[@ history_head] = y;
history_head = (history_head + 1) mod max_history;

// ── Orbit the room center ─────────────────────────────────────────────────────
// Speed ramps from 0.7 to 1.5 deg/step as the boss loses HP
orbit_speed  = lerp(0.7, 1.5, 1 - (hp / max_hp));
orbit_angle += orbit_speed;

var _cx = room_width  * 0.5;
var _cy = room_height * 0.5;
x = _cx + orbit_radius * dcos(orbit_angle);
y = _cy - orbit_radius * dsin(orbit_angle); // positive Y is down in GML

// ── Hit cooldown ──────────────────────────────────────────────────────────────
if (hit_cooldown > 0) hit_cooldown--;

// ── Contact damage: player walks into the head ────────────────────────────────
if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
    var _p = global.currentPlayer;
    if (point_distance(x, y, _p.x, _p.y) < 18) {
        if (_p.hit_cooldown <= 0) {
            _p.hp         -= 8;
            _p.hit_cooldown = 60;
        }
    }
}

// ── Death ─────────────────────────────────────────────────────────────────────
if (hp <= 0) {
    // Full health restore for every player form
    if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
        global.currentPlayer.hp = global.currentPlayer.max_hp;
    }
    global.player_hp = 50; // so human form returns to full HP on revert
    global.human_hp  = 50;

    // Destroy all living segments
    for (var _i = 0; _i < ds_list_size(segment_list); _i++) {
        var _s = segment_list[| _i];
        if (instance_exists(_s)) instance_destroy(_s);
    }
    ds_list_destroy(segment_list);
    segment_list = -1; // prevent double-free in CleanUp

    instance_destroy();
}
