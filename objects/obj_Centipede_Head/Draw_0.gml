// Flash white when recently hit, otherwise deep red — placeholder for final sprite
var _tint = (hit_cooldown > 0) ? c_white : c_red;
draw_sprite_ext(spr_Rock_Normal, 0, x, y, 0.7, 0.7, 0, _tint, 1);
