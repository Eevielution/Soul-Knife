/// @description Establish key vars
global.currentPlayer = id
isPlayer = true
global.PlayerHighlightExisits = true;
instance_create_layer(x, y, "Instances", obj_Player_Highlight)
attacking = false
frame_attack = 0
hsp = 0
vsp = 0


max_hp = 50
hp = max_hp