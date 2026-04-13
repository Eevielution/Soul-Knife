/// @description Establish key vars

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


hp = 100
max_hp = hp

// player health bar
healthbar_width = 100;
healthbar_height = 12;
healthbar_x = (180 / 2) - (healthbar_width / 2);
healthbar_y = 20;