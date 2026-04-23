// Boss HP bar pinned to the top of the GUI layer
var _x1  = 60;
var _x2  = display_get_gui_width() - 60;
var _y   = 12;
var _h   = 12;
var _pct = 100 * hp / max_hp;

// Background border
draw_set_color(c_black);
draw_rectangle(_x1 - 2, _y - 2, _x2 + 2, _y + _h + 2, false);

// Health bar (green at full → red at low)
draw_healthbar(_x1, _y, _x2, _y + _h, _pct, c_dkgrey, c_red, c_lime, 0, true, true);

// Label
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);
draw_text((_x1 + _x2) * 0.5, _y + _h * 0.5, "THE CENTIPEDE");
draw_set_halign(fa_left);
draw_set_valign(fa_top);
