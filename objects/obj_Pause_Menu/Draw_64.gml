// ── Layout ─────────────────────────────────────────────────────────────────────
// All sprites drawn at _s × their natural pixel size.
// Natural sizes:
//   buttons 116×26, arrow 13×20, frame 112×136 (8px border → 96×120 content)
//   slider 158×20, slider-arrow 8×14, labels 42/23/66 × 12
//   controls diagram 106×184
var _W    = display_get_gui_width();
var _H    = display_get_gui_height();
var _s    = 2.5; // master UI scale

// Scaled dimensions
var _bw   = floor(116 * _s);  // button width   290
var _bh   = floor(26  * _s);  // button height   65
var _bg   = 18;               // gap between buttons (px, not scaled)
var _aw   = floor(13  * _s);  // arrow width     32
var _ah   = floor(20  * _s);  // arrow height    50
var _fw   = floor(112 * _s);  // frame width    280
var _fh   = floor(136 * _s);  // frame height   340
var _brd  = floor(8   * _s);  // frame border    20  (8px × 2.5)

var _col_h  = 4 * _bh + 3 * _bg;          // button column total height = 314
var _menu_w = _aw + 10 + _bw + 36 + _fw;  // total menu width           = 648

// Title block above both columns
var _title_h  = floor(10 * _s) + 14;  // ~39 px
var _title_gap = 14;
var _total_h  = _title_h + _title_gap + _fh;

// Top-left anchor for the entire block
var _ox  = floor((_W - _menu_w)  * 0.5);
var _oy  = floor((_H - _total_h) * 0.5);

// Frame
var _fx  = _ox + _aw + 10 + _bw + 36;
var _fy  = _oy + _title_h + _title_gap;

// Button column (vertically centred inside the frame height)
var _bx  = _fx - 36 - _bw;
var _by0 = _fy + floor((_fh - _col_h) * 0.5);

// Arrow column (left of buttons)
var _ax  = _bx - _aw - 8;

// Content area inside frame
var _cx  = _fx + _brd;
var _cy  = _fy + _brd;
var _cw  = _fw - 2 * _brd;  // 240
var _ch  = _fh - 2 * _brd;  // 300

// ── Dim backdrop ───────────────────────────────────────────────────────────────
draw_set_alpha(0.62);
draw_set_color(c_black);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

// ── PAUSED title ───────────────────────────────────────────────────────────────
draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text_transformed(_ox + floor(_menu_w * 0.5), _oy, "PAUSED", _s, _s, 0);
draw_set_halign(fa_left);

// ── Options arrow (points at the hovered button) ──────────────────────────────
// Only draw when the mouse is actually over a button
if (hovered >= 0) {
    var _arrow_draw_y = _by0 + hovered * (_bh + _bg);
    var _arrow_y = _arrow_draw_y - sprite_get_yoffset(spr_Options_Arrow) * _s
                   + floor((sprite_get_height(spr_Resume_Unselected) - sprite_get_height(spr_Options_Arrow)) * _s * 0.5);
    draw_sprite_ext(spr_Options_Arrow, 0, _ax, _arrow_y, _s, _s, 0, c_white, 1);
}

// ── Four menu buttons ──────────────────────────────────────────────────────────
var _sel   = [spr_Resume_Selected,   spr_Settings_Selected,   spr_Controls_Selected,   spr_Quit_Selected];
var _unsel = [spr_Resume_Unselected, spr_Settings_Unselected, spr_Controls_Unselected, spr_Quit_Unselected];
for (var _i = 0; _i < 4; _i++) {
    var _spr = (_i == hovered) ? _sel[_i] : _unsel[_i];
    draw_sprite_ext(_spr, 0, _bx, _by0 + _i * (_bh + _bg), _s, _s, 0, c_white, 1);
}

// ── Right panel frame ──────────────────────────────────────────────────────────
draw_sprite_ext(spr_Frame, 0, _fx, _fy, _s, _s, 0, c_white, 1);

// ── Panel content ──────────────────────────────────────────────────────────────
if (panel == 1) {
    // Settings — 3 sliders
    // Slider track scaled so it fits neatly inside the 240px content width
    var _sl_s  = (_cw - 4) / 158.0;  // fills content width with 2px margin each side
    var _sl_w  = floor(158 * _sl_s);
    var _sl_h  = floor(20  * _sl_s);
    var _th_s  = _sl_s;
    var _th_w  = floor(8   * _th_s);
    var _th_h  = floor(14  * _th_s);
    var _lbl_s = _s * 0.5;            // ~1.25× for compact labels
    var _labels = [spr_Volume_Label, spr_SFX_Label, spr_Background_Label];
    var _vals   = [sl_master, sl_sfx, sl_bgm];

    var _lbl_h    = floor(12 * _lbl_s);
    var _row_h    = _lbl_h + 6 + _sl_h;
    var _row_gap  = floor(_ch * 0.04);
    var _rows_tot = 3 * _row_h + 2 * _row_gap;
    var _row_oy   = _cy + floor((_ch - _rows_tot) * 0.5);
    var _sl_ox    = _cx + 2;  // left-align with a tiny margin

    for (var _i = 0; _i < 3; _i++) {
        var _ry  = _row_oy + _i * (_row_h + _row_gap);
        var _sly = _ry + _lbl_h + 6;
        var _v   = _vals[_i];

        // Label
        draw_sprite_ext(_labels[_i], 0, _cx + 2, _ry, _lbl_s, _lbl_s, 0, c_white, 1);

        // Slider track
        draw_sprite_ext(spr_Slider, 0, _sl_ox, _sly, _sl_s, _sl_s, 0, c_white, 1);

        // Thumb
        var _th_x = _sl_ox + floor(_v * _sl_w) - floor(_th_w * 0.5);
        var _th_y = _sly + floor((_sl_h - _th_h) * 0.5);
        draw_sprite_ext(spr_Slider_Arrow, 0, _th_x, _th_y, _th_s, _th_s, 0, c_white, 1);
    }

} else if (panel == 2) {
    // Controls diagram — scale to fill as much of the content area as possible
    var _diag_s = min(_cw / 106.0, _ch / 184.0);
    var _dw = floor(106 * _diag_s);
    var _dh = floor(184 * _diag_s);
    draw_sprite_ext(spr_Controls_Diagram, 0,
        _cx + floor((_cw - _dw) * 0.5),
        _cy + floor((_ch - _dh) * 0.5),
        _diag_s, _diag_s, 0, c_white, 1);

} else {
    // Default: minimap / rooms visited
    var _mcx = _cx + floor(_cw * 0.5);  // horizontal centre of content area
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(-1);
    draw_text_transformed(_mcx, _cy + 8,  "ROOMS VISITED", 1.3, 1.3, 0);
    draw_text_transformed(_mcx, _cy + 32, string(global.rooms_visited), 2.2, 2.2, 0);

    // 5×5 dot grid
    var _dot  = 14;
    var _dgap = 6;
    var _grid_w = 5 * _dot + 4 * _dgap;   // 90
    var _grid_h = 5 * _dot + 4 * _dgap;   // 90
    var _gx = _cx + floor((_cw - _grid_w) * 0.5);
    var _gy = _cy + floor(_ch * 0.45);
    for (var _r = 0; _r < 5; _r++) {
        for (var _c = 0; _c < 5; _c++) {
            var _idx = _r * 5 + _c;
            var _dx  = _gx + _c * (_dot + _dgap);
            var _dy  = _gy + _r * (_dot + _dgap);
            if (_idx == global.rooms_visited - 1) {
                draw_set_color(c_lime);
            } else if (_idx < global.rooms_visited - 1) {
                draw_set_color(make_colour_rgb(90, 90, 90));
            } else {
                draw_set_color(make_colour_rgb(35, 35, 35));
            }
            draw_rectangle(_dx, _dy, _dx + _dot, _dy + _dot, false);
        }
    }
    draw_set_halign(fa_left);
}

// ── Reset draw state ───────────────────────────────────────────────────────────
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
