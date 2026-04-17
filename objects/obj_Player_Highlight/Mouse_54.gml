// Right Click — Transform into the rat or termite the player is currently touching
// Blocked if already transformed (revert is handled by holding, not pressing)
if (!instance_exists(global.currentPlayer)) exit;
if (global.currentPlayer.object_index == obj_Rat_Enemy) exit;
if (global.currentPlayer.object_index == obj_Termite_Enemy) exit;

// Check for rat first, then termite
var _target = noone;
with (global.currentPlayer) {
    _target = instance_place(x, y, obj_Rat_Enemy);
    if (_target == noone) {
        _target = instance_place(x, y, obj_Termite_Enemy);
    }
}

if (_target != noone) {
    with (_target) {
        // Rat uses Alarm_0, Termite uses Alarm_2
        if (object_index == obj_Rat_Enemy) alarm[0] = 1;
        else alarm[2] = 1;
    }
}
