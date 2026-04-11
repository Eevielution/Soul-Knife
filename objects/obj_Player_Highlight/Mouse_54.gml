// Right Click — Transform into the rat the player is currently touching
// Blocked if already transformed (revert is handled by holding, not pressing)
if (!instance_exists(global.currentPlayer)) exit;
if (global.currentPlayer.object_index == obj_Rat_Enemy) exit;

// Run the collision check FROM the player so it uses the player's mask
var _target = noone;
with (global.currentPlayer) {
    _target = instance_place(x, y, obj_Rat_Enemy);
}

if (_target != noone) {
    with (_target) {
        alarm[0] = 1;
    }
}
