// ── Move first ───────────────────────────────────────────────────────────────
move_spd = lerp(1.5, 3.0, 1 - (hp / max_hp));
x += lengthdir_x(move_spd, head_dir);
y += lengthdir_y(move_spd, head_dir);
x = clamp(x, 16, room_width  - 16);
y = clamp(y, 16, room_height - 16);

// ── Write history AFTER moving (distance-based) ───────────────────────────────
// One entry per segment_step_dist pixels so body spacing is always ~14 px.
if (point_distance(x, y, last_hist_x, last_hist_y) >= segment_step_dist) {
    pos_history_x[@ history_head] = x;
    pos_history_y[@ history_head] = y;
    last_hist_x  = x;
    last_hist_y  = y;
    history_head = (history_head + 1) mod max_history;
}

// ── Turn cooldown ─────────────────────────────────────────────────────────────
if (turn_cd > 0) turn_cd--;

// ── Lookahead: avoid walls AND obj_Solid ──────────────────────────────────────
var _margin   = 28;
var _look     = 32;
var _is_horiz = (head_dir == 0 || head_dir == 180);

var _nx = x + lengthdir_x(_look, head_dir);
var _ny = y + lengthdir_y(_look, head_dir);
var _ahead_blocked = (
    _nx < _margin || _nx > room_width  - _margin ||
    _ny < _margin || _ny > room_height - _margin ||
    collision_point(_nx, _ny, obj_Solid, false, false) != noone
);

if (_ahead_blocked && turn_cd <= 0) {
    var _tx = room_width  * 0.5;
    var _ty = room_height * 0.5;
    if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
        _tx = global.currentPlayer.x;
        _ty = global.currentPlayer.y;
    }

    // Preferred = perpendicular turn toward player; alt = the other perpendicular
    var _pref = _is_horiz ? ((_ty > y) ? 270 : 90) : ((_tx > x) ? 0 : 180);
    var _alt  = _is_horiz ? ((_pref == 270) ? 90 : 270) : ((_pref == 0) ? 180 : 0);

    // Test preferred direction; fall back to alt; last resort: reverse
    var _px2 = x + lengthdir_x(_look, _pref);
    var _py2 = y + lengthdir_y(_look, _pref);
    var _pref_ok = (_px2 >= _margin && _px2 <= room_width  - _margin &&
                    _py2 >= _margin && _py2 <= room_height - _margin &&
                    collision_point(_px2, _py2, obj_Solid, false, false) == noone);

    if (_pref_ok) {
        head_dir = _pref;
    } else {
        var _ax2 = x + lengthdir_x(_look, _alt);
        var _ay2 = y + lengthdir_y(_look, _alt);
        var _alt_ok = (_ax2 >= _margin && _ax2 <= room_width  - _margin &&
                       _ay2 >= _margin && _ay2 <= room_height - _margin &&
                       collision_point(_ax2, _ay2, obj_Solid, false, false) == noone);
        head_dir = _alt_ok ? _alt : ((head_dir + 180) mod 360);
    }
    turn_cd = 30;
}

// ── Periodic hunt-turn: steer toward the player ──────────────────────────────
// Only fires when not in obstacle-avoidance cooldown.
if (turn_cd <= 0 && variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
    var _chance = lerp(0.006, 0.018, 1 - (hp / max_hp));
    if (random(1) < _chance) {
        var _px  = global.currentPlayer.x;
        var _py  = global.currentPlayer.y;
        var _new_dir = -1;
        if (_is_horiz) {
            if (abs(_py - y) > 16) _new_dir = (_py > y) ? 270 : 90;
        } else {
            if (abs(_px - x) > 16) _new_dir = (_px > x) ? 0 : 180;
        }
        // Only apply hunt-turn if that direction is clear
        if (_new_dir != -1) {
            var _hx2 = x + lengthdir_x(_look, _new_dir);
            var _hy2 = y + lengthdir_y(_look, _new_dir);
            if (_hx2 >= _margin && _hx2 <= room_width  - _margin &&
                _hy2 >= _margin && _hy2 <= room_height - _margin &&
                collision_point(_hx2, _hy2, obj_Solid, false, false) == noone) {
                head_dir = _new_dir;
                turn_cd  = 30;
            }
        }
    }
}

// ── Hit cooldown ─────────────────────────────────────────────────────────────
if (hit_cooldown > 0) hit_cooldown--;

// ── Contact damage ───────────────────────────────────────────────────────────
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
    if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
        global.currentPlayer.hp = global.currentPlayer.max_hp;
    }
    global.player_hp = 50;
    global.human_hp  = 50;

    for (var _i = 0; _i < ds_list_size(segment_list); _i++) {
        var _s = segment_list[| _i];
        if (instance_exists(_s)) instance_destroy(_s);
    }
    ds_list_destroy(segment_list);
    segment_list = -1;

    instance_destroy();
}
