// -- Layout (must match Draw_64 exactly) --------------------------------------
var _W    = display_get_gui_width();
var _H    = display_get_gui_height();
var _s    = 2.5;

var _bw   = floor(116 * _s);
var _bh   = floor(26  * _s);
var _bg   = 18;
var _aw   = floor(13  * _s);
var _fw   = floor(112 * _s);
var _fh   = floor(136 * _s);
var _brd  = floor(8   * _s);

var _col_h    = 4 * _bh + 3 * _bg;
var _menu_w   = _aw + 10 + _bw + 36 + _fw;
var _title_h  = floor(10 * _s) + 14;
var _title_gap = 14;
var _total_h  = _title_h + _title_gap + _fh;

var _ox  = floor((_W - _menu_w)  * 0.5);
var _oy  = floor((_H - _total_h) * 0.5);

var _fx  = _ox + _aw + 10 + _bw + 36;
var _fy  = _oy + _title_h + _title_gap;
var _bx  = _fx - 36 - _bw;
var _by0 = _fy + floor((_fh - _col_h) * 0.5);

var _cx  = _fx + _brd;
var _cy  = _fy + _brd;
var _cw  = _fw - 2 * _brd;
var _ch  = _fh - 2 * _brd;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// -- ESC / close ---------------------------------------------------------------
if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
    exit;
}

// -- Button hover + click ------------------------------------------------------
// All button sprites are 116x26. Use one sprite as a shared origin reference
// so mismatched per-sprite origins do not desync hit boxes.
var _ref_ox = sprite_get_xoffset(spr_Resume_Unselected) * _s;
var _ref_oy = sprite_get_yoffset(spr_Resume_Unselected) * _s;

hovered = -1;
var _btn_clicked = false;

for (var _i = 0; _i < 4; _i++) {
    var _draw_y = _by0 + _i * (_bh + _bg);

    var _hit_l = _bx - _ref_ox;
    var _hit_t = _draw_y - _ref_oy;
    var _hit_r = _hit_l + 116 * _s;
    var _hit_b = _hit_t + 26  * _s;

    if (_mx >= _hit_l && _mx <= _hit_r && _my >= _hit_t && _my <= _hit_b) {
        hovered = _i;
        if (mouse_check_button_pressed(mb_left)) {
            _btn_clicked = true;
            switch (_i) {
                case 0: // Resume
                    instance_destroy();
                    exit;
                case 1: // Settings
                    panel = (panel == 1) ? 0 : 1;
                    break;
                case 2: // Controls
                    panel = (panel == 2) ? 0 : 2;
                    break;
                case 3: // Quit
                    game_end();
                    exit;
            }
        }
        break;
    }
}

// -- Slider interaction (settings panel only) ---------------------------------
if (panel == 1 && !_btn_clicked) {
    var _sl_s    = (_cw - 4) / 158.0;
    var _sl_w    = floor(158 * _sl_s);
    var _sl_h    = floor(20  * _sl_s);
    var _lbl_s   = _s * 0.5;
    var _lbl_h   = floor(12 * _lbl_s);
    var _row_h   = _lbl_h + 6 + _sl_h;
    var _row_gap = floor(_ch * 0.04);
    var _rows_tot = 3 * _row_h + 2 * _row_gap;
    var _row_oy  = _cy + floor((_ch - _rows_tot) * 0.5);

    // Match draw position + sprite origin for precise hit testing.
    var _sl_draw_x = _cx + 2;
    var _sl_ox_off = sprite_get_xoffset(spr_Slider) * _sl_s;
    var _sl_oy_off = sprite_get_yoffset(spr_Slider) * _sl_s;
    var _sl_left   = _sl_draw_x - _sl_ox_off;

    var _sly_draw = [
        _row_oy + 0 * (_row_h + _row_gap) + _lbl_h + 6,
        _row_oy + 1 * (_row_h + _row_gap) + _lbl_h + 6,
        _row_oy + 2 * (_row_h + _row_gap) + _lbl_h + 6,
    ];

    if (mouse_check_button_pressed(mb_left) && dragging == -1) {
        for (var _i = 0; _i < 3; _i++) {
            var _track_t = _sly_draw[_i] - _sl_oy_off;
            var _track_b = _track_t + _sl_h;
            if (_mx >= _sl_left && _mx <= _sl_left + _sl_w &&
                _my >= _track_t - 20 && _my <= _track_b + 20) {
                dragging = _i;
                break;
            }
        }
    }

    if (dragging >= 0 && mouse_check_button(mb_left)) {
        var _v = clamp((_mx - _sl_left) / _sl_w, 0, 1);
        switch (dragging) {
            case 0: sl_master = _v; global.vol_master = _v; break;
            case 1: sl_sfx    = _v; global.vol_sfx    = _v; break;
            case 2: sl_bgm    = _v; global.vol_bgm    = _v; break;
        }
        if (audio_is_playing(global.bgm_inst)) {
            audio_sound_gain(global.bgm_inst, global.vol_bgm * global.vol_master, 0);
        }
        var _sfx_vol  = global.vol_sfx * global.vol_master;
        var _sfx_list = [snd_door, snd_enemy_attack, snd_gameover, snd_kill,
                         snd_slash1, snd_slash2, snd_slash3, snd_transform];
        for (var _j = 0; _j < array_length(_sfx_list); _j++) {
            audio_sound_gain(_sfx_list[_j], _sfx_vol, 0);
        }
    }

    if (mouse_check_button_released(mb_left)) {
        dragging = -1;
    }
}
