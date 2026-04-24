// ── Cooldown tick ───────────────────────────────────────────────────────────
if (hit_cooldown > 0) hit_cooldown--;

// ── Shake tick ──────────────────────────────────────────────────────────────
if (shake_timer > 0) {
    shake_timer--;
    shake_x = random_range(-shake_intensity, shake_intensity);
    shake_y = random_range(-shake_intensity, shake_intensity);
} else {
    shake_x = 0;
    shake_y = 0;
}

// ── Push-out: keep the current player from overlapping while intact ──────────
if (!destroyed) {
    if (!variable_global_exists("currentPlayer") || !instance_exists(global.currentPlayer)) exit;
    var _p = global.currentPlayer;
    if (point_in_rectangle(_p.x, _p.y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
        with (_p) {
            var _bl = other.bbox_left;
            var _br = other.bbox_right;
            var _bt = other.bbox_top;
            var _bb = other.bbox_bottom;
            var _dl = x - _bl;
            var _dr = _br - x;
            var _dt = y - _bt;
            var _db = _bb - y;
            if (min(_dl, _dr) < min(_dt, _db)) {
                x = (_dl < _dr) ? _bl : _br;
            } else {
                y = (_dt < _db) ? _bt : _bb;
            }
        }
    }
}


if (sprite_index == spr_Rock_Pieces){
	solid = false;
}