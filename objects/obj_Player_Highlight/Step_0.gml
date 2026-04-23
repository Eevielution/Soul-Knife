if (!instance_exists(global.currentPlayer)) {
    instance_destroy();
    exit;
}

// Always sit exactly on the player — no chasing
x = global.currentPlayer.x;
y = global.currentPlayer.y;
speed = 0;

// --- Animal-form door check (uses the animal's own mask, not the highlight's tiny one) ---
var _cp_idx = global.currentPlayer.object_index;
if (_cp_idx == obj_Rat_Enemy || _cp_idx == obj_Termite_Enemy) {
    var _door = noone;
    with (global.currentPlayer) {
        _door = instance_place(x, y, obj_Door);
    }
    if (_door != noone) {
        var _opp = [1, 0, 3, 2];
        global.entry_door_side = _opp[_door.loc_name];
        var _cands;
        switch (global.entry_door_side) {
            case 0: _cands = [rm_16x9, rm_16x18, rm_18x32]; break;
            case 1: _cands = [rm_16x9, rm_16x18, rm_18x32, rm_L]; break;
            case 2: _cands = [rm_16x9, rm_16x18, rm_18x32]; break;
            case 3: _cands = [rm_16x9, rm_16x18, rm_18x32, rm_L]; break;
            default: exit;
        }
        global.player_hp = global.human_hp; // preserve human HP, not the animal's
        if (!instance_exists(obj_Transition)) {
            audio_play_sound(snd_door, 1, false);
            global.transition_room = _cands[irandom(array_length(_cands) - 1)];
            instance_create_layer(0, 0, "Instances", obj_Transition);
        }
        exit;
    }
}

// This lets you turn back into a human (from rat or termite)
if ((global.currentPlayer.object_index == obj_Rat_Enemy || global.currentPlayer.object_index == obj_Termite_Enemy) && mouse_check_button(mb_right)) {
    revert_hold_timer++;
    if (revert_hold_timer >= 180) {
        revert_hold_timer = 0;
        var _animal = global.currentPlayer;
        var _rx = _animal.x;
        var _ry = _animal.y;
        global.player_hp = global.human_hp;
        knifeOut = true;
        _animal.isPlayer = false;
        _animal.persistent = false;
        var _new_player = instance_create_layer(_rx, _ry, "Instances", obj_Player);
        with (_animal) { instance_destroy(); }
    }
} else {
    revert_hold_timer = 0;
}

// ---- Point at nearest enemy, or face player's movement direction ----
var _player = global.currentPlayer;

// Find closest enemy (rat or termite), skipping whichever is the player
var _nearest = noone;
var _nearest_dist = infinity;
with (obj_Rat_Enemy) {
    if (id == global.currentPlayer) continue;
    var _d = point_distance(_player.x, _player.y, x, y);
    if (_d < _nearest_dist) {
        _nearest_dist = _d;
        _nearest = id;
    }
}
with (obj_Termite_Enemy) {
    if (id == global.currentPlayer) continue;
    var _d = point_distance(_player.x, _player.y, x, y);
    if (_d < _nearest_dist) {
        _nearest_dist = _d;
        _nearest = id;
    }
}

if (_nearest != noone) {
    // Enemy present — point at it
    image_angle = point_direction(x, y, _nearest.x, _nearest.y) - 90;
} else {
    // No enemies — point in the direction the player is facing
    var _hsp = _player.hsp;
    var _vsp = _player.vsp;
    if (_hsp != 0 || _vsp != 0) {
        image_angle = point_direction(0, 0, _hsp, _vsp) - 90;
    }
    // If player is standing still, keep current image_angle
}

