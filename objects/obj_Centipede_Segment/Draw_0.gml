// Yellow flash while "open"/firing; otherwise a muted dark-red — placeholder for final sprite
var _tint = (open_timer > 0) ? c_yellow : merge_colour(c_red, c_dkgrey, 0.5);
draw_sprite_ext(spr_Rock_Normal, 0, x, y, 0.45, 0.45, 0, _tint, 1);
