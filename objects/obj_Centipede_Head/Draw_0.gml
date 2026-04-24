// Sprite orientation assumptions (adjust if yours differ):
//   spr_Centipede_Head_Horizontal — drawn facing RIGHT  (xscale -1 to face left)
//   spr_Centipede_Head_Vertical   — drawn facing DOWN   (yscale -1 to face up)
// In GML: head_dir=0=right, 90=up, 180=left, 270=down
// Sprite origin should be center (8,8) for correct flip pivot.
var _spr, _xs, _ys;
if (head_dir == 0 || head_dir == 180) {
    _spr = spr_Centipede_Head_Horizontal;
    _xs  = (head_dir == 0) ? 1 : -1;
    _ys  = 1;
} else {
    _spr = spr_Centipede_Head_Vertical;
    _xs  = 1;
    _ys  = (head_dir == 270) ? 1 : -1;
}

// Animate at 6 fps using current_time (milliseconds)
var _frame = (current_time div 166) mod sprite_get_number(_spr);

var _alpha = (hit_cooldown > 0 && (hit_cooldown mod 6) < 3) ? 0.4 : 1.0;

// Origin-compensated draw position (handles any sprite origin setting)
var _ox = sprite_get_xoffset(_spr);
var _oy = sprite_get_yoffset(_spr);
var _draw_x = x - (8 - _ox) * _xs;
var _draw_y = y - (8 - _oy) * _ys;

// Glow pass (additive blend, slightly larger, teal tint)
gpu_set_blendmode(bm_add);
draw_sprite_ext(_spr, _frame, _draw_x, _draw_y, _xs * 1.15, _ys * 1.15, 0, c_aqua, 0.35);
gpu_set_blendmode(bm_normal);

// Normal draw
draw_sprite_ext(_spr, _frame, _draw_x, _draw_y, _xs, _ys, 0, c_white, _alpha);
