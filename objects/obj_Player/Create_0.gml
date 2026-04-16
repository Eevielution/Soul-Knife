/// @description Establish key vars
event_inherited(); // defines collision() from obj_Movement_Parent

// If a player-controlled rat persisted from a previous room, this obj_Player is redundant
var _rat = noone;
with (obj_Rat_Enemy) {
    if (isPlayer) { _rat = id; break; }
}
if (_rat != noone) {
    instance_destroy();
    exit;
}

depth = -1; // in front of highlight
global.currentPlayer = id
isPlayer = true
global.PlayerHighlightExisits = true;
// Only create the highlight if it doesn't already exist (e.g. reverting from rat form)
if (!instance_exists(obj_Player_Highlight)) {
    instance_create_layer(x, y, "Instances", obj_Player_Highlight)
}
attacking = false
frame_attack = 0
hsp = 0
vsp = 0


max_hp = 50
hp = (global.player_hp > 0) ? global.player_hp : max_hp
bleed_rate = 1/120 // 1 HP every 2 seconds
hit_cooldown = 0   // frames before next enemy hit can land