// ── Layout (must match Draw_64 exactly) ──────────────────────────────────────
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

var _col_h   = 4 * _bh + 3 * _bg;
var _menu_w  = _aw + 10 + _bw + 36 + _fw;
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

// ── ESC / close ────────────────────────────────────────────────────────────────
if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
    exit;
}

// ── Button hover + click ───────────────────────────────────────────────────────
// Reset hover every step — only set if mouse is actually over a button.
// All button sprites are the same size (116×26). Use Resume as the single
// origin reference for every button so a bad per-sprite value can't
// shift one button's hit rect relative to the others.
var _ref_ox = sprite_get_xoffset(spr_Resume_Unselected) * _s;
var _ref_oy = sprite_get_yoffset(spr_Resume_Unselected) * _s;

hovered = -1;
var _btn_clicked = false;

for (var _i = 0; _i < 4; _i++) {
    var _draw_y = _by0 + _i * (_bh + _bg);

    var _hit_l = _bx     - _ref_ox;
    var _hit_t = _draw_y - _ref_oy;
    var _hit_r = _hit_l  + 116 * _s;
    var _hit_b = _hit_t  + 26  * _s;

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

// ── Slider interaction (settings panel only) ───────────────────────────────────
if (panel == 1 && !_btn_clicked) {
    var _sl_s   = (_cw - 4) / 158.0;
    var _sl_w   = floor(158 * _sl_s);
    var _sl_h   = floor(20  * _sl_s);
    var _lbl_s  = _s * 0.5;
    var _lbl_h  = floor(12 * _lbl_s);
    var _row_h  = _lbl_h + 6 + _sl_h;
    var _row_gap = floor(_ch * 0.04);
    var _rows_tot = 3 * _row_h + 2 * _row_gap;
    var _row_oy = _cy + floor((_ch - _rows_tot) * 0.5);

    // Compute slider draw positions the same way Draw_64 does
    var _sl_draw_x = _cx + 2;
    var _sl_ox_off = sprite_get_xoffset(spr_Slider) * _sl_s;
    var _sl_oy_off = sprite_get_yoffset(spr_Slider) * _sl_s;
    var _sl_left   = _sl_draw_x - _sl_ox_off;  // actual left edge of track

    var _sly_draw = [
        _row_oy + 0 * (_row_h + _row_gap) + _lbl_h + 6,
        _row_oy + 1 * (_row_h + _row_gap) + _lbl_h + 6,
        _row_oy + 2 * (_row_h + _row_gap) + _lbl_h + 6,
    ];

    // Start drag: use full slider bounding box + generous vertical padding
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

    // Update value while dragging
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

    if (mouse_check_button_released(mb_left)) dragging = -1;
}


var _col_h  = 4 * _bh + 3 * _bg;
var _menu_w = _aw + 10 + _bw + 36 + _fw;

var _title_h   = floor(10 * _s) + 14;
var _title_gap = 14;
var _total_h   = _title_h + _title_gap + _fh;

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

// Offset drawn position by sprite origin so hit rects match what's on screen
var _btn_ox = sprite_get_xoffset(spr_Resume_Unselected) * _s;
var _btn_oy = sprite_get_yoffset(spr_Resume_Unselected) * _s;
var _btn_x  = _bx  - _btn_ox;
var _btn_y0 = _by0 - _btn_oy;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// ── ESC / close ────────────────────────────────────────────────────────────────
if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
    exit;
}

// ── Button hover + click ───────────────────────────────────────────────────────
var _btn_clicked = false;
for (var _i = 0; _i < 4; _i++) {
    var _by_tl = _btn_y0 + _i * (_bh + _bg);
    if (_mx >= _btn_x && _mx <= _btn_x + _bw &&
        _my >= _by_tl  && _my <= _by_tl  + _bh) {
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
                case 3: // Quit — close the game
                    game_end();
                    exit;
            }
        }
        break;
    }
}

// ── Slider interaction (settings panel only) ───────────────────────────────────
// _btn_clicked guard prevents a button press from also starting a slider drag
if (panel == 1 && !_btn_clicked) {
    var _sl_s  = (_cw - 4) / 158.0;
    var _sl_w  = floor(158 * _sl_s);
    var _sl_h  = floor(20  * _sl_s);

    // Account for slider sprite's own origin
    var _sl_ox_off = sprite_get_xoffset(spr_Slider) * _sl_s;
    var _sl_oy_off = sprite_get_yoffset(spr_Slider) * _sl_s;
    var _sl_left   = (_cx + 2) - _sl_ox_off;   // actual left edge of track

    var _lbl_s    = _s * 0.5;
    var _lbl_h    = floor(12 * _lbl_s);
    var _row_h    = _lbl_h + 6 + _sl_h;
    var _row_gap  = floor(_ch * 0.04);
    var _rows_tot = 3 * _row_h + 2 * _row_gap;
    var _row_oy   = _cy + floor((_ch - _rows_tot) * 0.5);

    // Top edge of each slider track (draw y minus sprite y-origin)
    var _sly = [
        _row_oy + 0 * (_row_h + _row_gap) + _lbl_h + 6 - _sl_oy_off,
        _row_oy + 1 * (_row_h + _row_gap) + _lbl_h + 6 - _sl_oy_off,
        _row_oy + 2 * (_row_h + _row_gap) + _lbl_h + 6 - _sl_oy_off,
    ];

    // Start drag — generous ±16 px vertical padding so the track is easy to grab
    if (mouse_check_button_pressed(mb_left) && dragging == -1) {
        for (var _i = 0; _i < 3; _i++) {
            if (_mx >= _sl_left && _mx <= _sl_left + _sl_w &&
                _my >= _sly[_i] - 16 && _my <= _sly[_i] + _sl_h + 16) {
                dragging = _i;
                break;
            }
        }
    }

    // Update value while dragging
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

    if (mouse_check_button_released(mb_left)) dragging = -1;
}


var _bw   = floor(116 * _s);
var _bh   = floor(26  * _s);
var _bg   = 18;
var _aw   = floor(13  * _s);
var _fw   = floor(112 * _s);
var _fh   = floor(136 * _s);
var _brd  = floor(8   * _s);

var _col_h  = 4 * _bh + 3 * _bg;
var _menu_w = _aw + 10 + _bw + 36 + _fw;

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

// Mouse position in GUI space
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// ── ESC / close ────────────────────────────────────────────────────────────────
if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
    exit;
}

// ── Button hover + click ───────────────────────────────────────────────────────
for (var _i = 0; _i < 4; _i++) {
    var _by = _by0 + _i * (_bh + _bg);
    if (_mx >= _bx && _mx <= _bx + _bw && _my >= _by && _my <= _by + _bh) {
        hovered = _i;
        if (mouse_check_button_pressed(mb_left)) {
            switch (_i) {
                case 0: // Resume
                    instance_destroy();
                    exit;
                case 1: // Settings — toggle settings panel
                    panel = (panel == 1) ? 0 : 1;
                    break;
                case 2: // Controls — toggle controls panel
                    panel = (panel == 2) ? 0 : 2;
                    break;
                case 3: // Quit
                    game_restart();
                    exit;
            }
        }
        break;
    }
}

// ── Slider interaction (settings panel only) ───────────────────────────────────
if (panel == 1) {
    var _sl_s  = (_cw - 4) / 158.0;
    var _sl_w  = floor(158 * _sl_s);
    var _sl_h  = floor(20  * _sl_s);
    var _lbl_s = _s * 0.5;
    var _lbl_h = floor(12 * _lbl_s);
    var _row_h   = _lbl_h + 6 + _sl_h;
    var _row_gap = floor(_ch * 0.04);
    var _rows_tot = 3 * _row_h + 2 * _row_gap;
    var _row_oy  = _cy + floor((_ch - _rows_tot) * 0.5);
    var _sl_ox   = _cx + 2;

    var _sly = [
        _row_oy + 0 * (_row_h + _row_gap) + _lbl_h + 6,
        _row_oy + 1 * (_row_h + _row_gap) + _lbl_h + 6,
        _row_oy + 2 * (_row_h + _row_gap) + _lbl_h + 6,
    ];

    // Start drag
    if (mouse_check_button_pressed(mb_left) && dragging == -1) {
        for (var _i = 0; _i < 3; _i++) {
            if (_mx >= _sl_ox && _mx <= _sl_ox + _sl_w &&
                _my >= _sly[_i] && _my <= _sly[_i] + _sl_h) {
                dragging = _i;
            }
        }
    }

    // Update while dragging
    if (dragging >= 0 && mouse_check_button(mb_left)) {
        var _v = clamp((_mx - _sl_ox) / _sl_w, 0, 1);
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

    if (mouse_check_button_released(mb_left)) dragging = -1;
}


// Mouse position in GUI space
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// ── ESC / close ────────────────────────────────────────────────────────────────
if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
    exit;
}

// ── Button hover ───────────────────────────────────────────────────────────────
for (var _i = 0; _i < 4; _i++) {
    var _by = _by0 + _i * 34;
    if (_mx >= _bx && _mx <= _bx + 116 && _my >= _by && _my <= _by + 26) {
        hovered = _i;
        break;
    }
}

// ── Button click ───────────────────────────────────────────────────────────────
if (mouse_check_button_pressed(mb_left)) {
    for (var _i = 0; _i < 4; _i++) {
        var _by = _by0 + _i * 34;
        if (_mx >= _bx && _mx <= _bx + 116 && _my >= _by && _my <= _by + 26) {
            switch (_i) {
                case 0: // Resume
                    instance_destroy();
                    exit;
                case 1: // Settings — toggle settings panel
                    panel = (panel == 1) ? 0 : 1;
                    break;
                case 2: // Controls — toggle controls panel
                    panel = (panel == 2) ? 0 : 2;
                    break;
                case 3: // Quit
                    game_restart();
                    exit;
            }
            break;
        }
    }
}

// ── Slider interaction (settings panel only) ───────────────────────────────────
if (panel == 1) {
    var _sc  = 0.6;           // draw scale for spr_Slider
    var _slw = 158 * _sc;     // track width  ~94.8 px
    var _slh = 20  * _sc;     // track height ~12 px
    var _slx = _cx;
    // Y positions of each slider track (label is 12px, 2px gap above track)
    var _sly0 = _cy + 14;
    var _sly1 = _cy + 54;
    var _sly2 = _cy + 94;
    var _sly  = [_sly0, _sly1, _sly2];

    // Start drag on click inside a track
    if (mouse_check_button_pressed(mb_left) && dragging == -1) {
        for (var _i = 0; _i < 3; _i++) {
            if (_mx >= _slx && _mx <= _slx + _slw &&
                _my >= _sly[_i] && _my <= _sly[_i] + _slh) {
                dragging = _i;
            }
        }
    }

    // Update value while dragging
    if (dragging >= 0 && mouse_check_button(mb_left)) {
        var _v = clamp((_mx - _slx) / _slw, 0, 1);
        switch (dragging) {
            case 0:
                sl_master = _v;
                global.vol_master = _v;
                break;
            case 1:
                sl_sfx = _v;
                global.vol_sfx = _v;
                break;
            case 2:
                sl_bgm = _v;
                global.vol_bgm = _v;
                break;
        }

        // Apply BGM gain immediately to the running loop
        if (audio_is_playing(global.bgm_inst)) {
            audio_sound_gain(global.bgm_inst, global.vol_bgm * global.vol_master, 0);
        }

        // Apply SFX gain to every effect asset (affects future plays)
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
