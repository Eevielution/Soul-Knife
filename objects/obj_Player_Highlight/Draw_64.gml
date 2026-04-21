if (!variable_global_exists("currentPlayer") || !instance_exists(global.currentPlayer)) exit;

var _hp  = global.currentPlayer.hp;
var _max = global.currentPlayer.max_hp;
var _pct = clamp(_hp / _max, 0, 1);

var _gw  = display_get_gui_width();
var _gh  = display_get_gui_height();
var _bw  = 200;
var _bh  = 32;
var _bx  = 160;
var _by  = 64;

draw_set_alpha(1);

// Background
draw_set_color(c_dkgray);
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);

// Fill — green → yellow → red as HP drops
var _col = (_pct > 0.6) ? c_lime : ((_pct > 0.3) ? c_yellow : c_red);
draw_set_color(_col);
draw_rectangle(_bx, _by, _bx + _bw * _pct, _by + _bh, false);

// Border
draw_set_color(c_white);
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);

// Label
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_text(_bx + _bw / 2, _by - 2, "HP  " + string(floor(_hp)) + " / " + string(_max));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- Creatures Slain counter (top-right) ---
draw_set_font(-1);
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(_gw - 12, 12, "Creatures Slain: " + string(global.creatures_slain));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
