if (!instance_exists(global.currentPlayer)) {
    instance_destroy();
    exit;
}

// Always sit exactly on the player — no chasing
x = global.currentPlayer.x;
y = global.currentPlayer.y;
speed = 0;

// This lets you turn back into a human
if (global.currentPlayer.object_index == obj_Rat_Enemy && mouse_check_button(mb_right)) {
    revert_hold_timer++;
    if (revert_hold_timer >= 180) {
        revert_hold_timer = 0;
        var _rat = global.currentPlayer;
        var _rx = _rat.x;
        var _ry = _rat.y;
        // Restore saved human HP
        global.player_hp = global.human_hp;
        knifeOut = true; // restore knife for human form
        // Mark rat as non-player before creating obj_Player so Create_0 doesn't self-destruct
        _rat.isPlayer = false;
        _rat.persistent = false;
        var _new_player = instance_create_layer(_rx, _ry, "Instances", obj_Player);
        with (_rat) { instance_destroy(); }
    }
} else {
    revert_hold_timer = 0;
}

// ---- Point at nearest enemy, or face player's movement direction ----
var _player = global.currentPlayer;

// Find closest obj_Rat_Enemy
var _nearest = noone;
var _nearest_dist = infinity;
with (obj_Rat_Enemy) {
    if (id == global.currentPlayer) continue; // skip the player-rat
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

