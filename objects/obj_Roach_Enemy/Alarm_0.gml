// This alarm is now ONLY triggered by right-click transform (Mouse_54 on obj_Player_Highlight)
// Save human HP so we can restore it if/when the player reverts
global.human_hp = global.currentPlayer.hp;
audio_play_sound(snd_transform, 1, false);

isPlayer = true
persistent = true   // survive room transitions while player-controlled
attacking = false
frame_attack = 0
instance_destroy(global.currentPlayer)
global.currentPlayer = id
global.PlayerHighlightExisits = true
obj_Player_Highlight.knifeOut = false
hp = max_hp;

// Faster movement in animal form
move_max_speed = 2.5
move_accel = 0.7

// Update camera to follow the new player instance
if (instance_exists(obj_Camera)) {
    obj_Camera.follow_target = id;
}
