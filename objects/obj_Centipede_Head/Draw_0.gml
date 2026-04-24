// Sprite orientation assumptions (adjust if yours differ):
//   spr_Centipede_Head_Horizontal — drawn facing RIGHT  (xscale -1 to face left)
//   spr_Centipede_Head_Vertical   — drawn facing DOWN   (yscale -1 to face up)
// In GML: head_dir=0=right, 90=up, 180=left, 270=down
// Sprite origin should be center (8,8) for correct flip pivot.
var _spr, _xs, _ys;
if (head_dir == 0 || head_dir == 180) {
    _spr = spr_Centipede_Head_Horizontal;
    _xs  = (head_dir == 0) ? 1 : -1;  // right=no flip; left=flip
    _ys  = 1;
} else {
    _spr = spr_Centipede_Head_Vertical;
    _xs  = 1;
    // head_dir 270 = moving DOWN  → sprite faces down → yscale  1 (no flip)
    // head_dir  90 = moving UP    → sprite faces down → yscale -1 (flip)
    _ys  = (head_dir == 270) ? 1 : -1;
}

var _alpha = (hit_cooldown > 0 && (hit_cooldown mod 6) < 3) ? 0.4 : 1.0;
draw_sprite_ext(_spr, 0, x, y, _xs, _ys, 0, c_white, _alpha);
