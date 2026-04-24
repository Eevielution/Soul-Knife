// ── Orphan check ──────────────────────────────────────────────────────────────
if (!instance_exists(head_id)) {
    instance_destroy();
    exit;
}

// ── Follow head's position history (snake-style trailing) ────────────────────
var _h = head_id;
// history_head always points to the NEXT slot to write, so the most recent
// position is at (history_head - 1). We want the position history_offset frames ago.
var _read = (_h.history_head - 1 - history_offset + _h.max_history * 4) mod _h.max_history;
x = _h.pos_history_x[_read];
y = _h.pos_history_y[_read];

// ── Hit cooldown ──────────────────────────────────────────────────────────────
if (hit_cooldown > 0) hit_cooldown--;

// ── Bullet fire ───────────────────────────────────────────────────────────────
fire_timer--;
if (fire_timer <= 0) {
    // Pick next fire interval based on boss remaining HP
    var _hp_frac = _h.hp / _h.max_hp;
    if      (_hp_frac > 0.66) fire_timer = 300; // phase 1: every 5 s
    else if (_hp_frac > 0.33) fire_timer = 210; // phase 2: every 3.5 s
    else                      fire_timer = 150; // phase 3: every 2.5 s

    open_timer = open_duration;

    if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
        var _px   = global.currentPlayer.x;
        var _py   = global.currentPlayer.y;
        var _base = point_direction(x, y, _px, _py);
        var _n    = ds_list_size(_h.segment_list);

        if (segment_index < _n * 0.33) {
            // Front third: V-shot — two bullets flanking the player angle
            var _b1 = instance_create_layer(x, y, "Instances", obj_Boss_Bullet);
            _b1.direction = _base + 18;
            _b1.speed     = 3;
            var _b2 = instance_create_layer(x, y, "Instances", obj_Boss_Bullet);
            _b2.direction = _base - 18;
            _b2.speed     = 3;
        } else if (segment_index < _n * 0.66) {
            // Middle third: single precise bullet, fastest
            var _b = instance_create_layer(x, y, "Instances", obj_Boss_Bullet);
            _b.direction = _base;
            _b.speed     = 3.5;
        } else {
            // Back third: wide 3-way spray, slower
            for (var _s = -1; _s <= 1; _s++) {
                var _b = instance_create_layer(x, y, "Instances", obj_Boss_Bullet);
                _b.direction = _base + _s * 28;
                _b.speed     = 2.5;
            }
        }
    }
}

// ── Open-flash timer ──────────────────────────────────────────────────────────
if (open_timer > 0) open_timer--;

// ── Contact damage to player ──────────────────────────────────────────────────
if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
    var _p = global.currentPlayer;
    if (point_distance(x, y, _p.x, _p.y) < 14) {
        if (_p.hit_cooldown <= 0) {
            _p.hp         -= 3;
            _p.hit_cooldown = 60;            if (_p.hp <= 0) global.killed_by_boss = true;        }
    }
}
