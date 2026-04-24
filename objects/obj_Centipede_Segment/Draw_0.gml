if (!instance_exists(head_id)) { exit; }
var _h = head_id;

// ── Sample three consecutive history positions: tail ← here → head ───────────
// "ahead"  = more recent in head's path (toward the head)
// "behind" = older in head's path       (toward the tail)
var _read   = (_h.history_head - 1 - history_offset + _h.max_history * 4) mod _h.max_history;
var _ahead  = (_read + 1) mod _h.max_history;
var _behind = (_read - 1 + _h.max_history) mod _h.max_history;

var _ax = _h.pos_history_x[_ahead];
var _ay = _h.pos_history_y[_ahead];
var _bx = _h.pos_history_x[_behind];
var _by = _h.pos_history_y[_behind];

// Direction vectors (from tail toward head through this segment)
var _prev_dx = x   - _bx;  // direction chain traveled TO reach here
var _prev_dy = y   - _by;
var _next_dx = _ax - x;    // direction chain travels FROM here toward head
var _next_dy = _ay - y;

// Hide segments still piled at the spawn point before they've spread out
if (abs(_prev_dx) + abs(_prev_dy) + abs(_next_dx) + abs(_next_dy) < 1) { exit; }

// Classify each leg as horizontal or vertical
var _prev_horiz = (abs(_prev_dx) >= abs(_prev_dy));
var _next_horiz = (abs(_next_dx) >= abs(_next_dy));

var _spr, _xs, _ys;
if (_prev_horiz == _next_horiz) {
    // ── Straight segment ──────────────────────────────────────────────────────
    _spr = _prev_horiz ? spr_Centipede_Body_Horizontal : spr_Centipede_Body_Vertical;
    _xs  = 1;
    _ys  = 1;
} else {
    // ── Corner segment ────────────────────────────────────────────────────────
    // Base orientation of spr_Centipede_Body_Corner assumed:
    //   chain came from LEFT moving right, then turned and went UP.
    //   xscale -1 = flip horizontally (horizontal leg now points left)
    //   yscale -1 = flip vertically   (vertical  leg now points down)
    // If corners appear rotated, swap the _vert_up / _horiz_right assignments.
    _spr = spr_Centipede_Body_Corner;

    var _horiz_right; // true = the horizontal leg of the corner points right
    var _vert_up;     // true = the vertical   leg of the corner points up

    if (_prev_horiz) {
        // Came in horizontally, leaves vertically
        _horiz_right = (_prev_dx > 0);
        _vert_up     = (_next_dy < 0);  // negative Y = up in GML
    } else {
        // Came in vertically, leaves horizontally
        _vert_up     = (_prev_dy < 0);
        _horiz_right = (_next_dx > 0);
    }

    _xs = _horiz_right ? 1 : -1;
    _ys = _vert_up     ? 1 : -1;
}

// Flash yellow briefly after this segment fires
var _tint = (open_timer > 0) ? c_yellow : c_white;
draw_sprite_ext(_spr, 0, x, y, _xs, _ys, 0, _tint, 1);
