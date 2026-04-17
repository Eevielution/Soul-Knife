// Triggered by right-click transform (Mouse_54 on obj_Player_Highlight)
global.human_hp = global.currentPlayer.hp;
audio_play_sound(snd_transform, 1, false);

isPlayer = true
persistent = true   // survive room transitions while player-controlled
instance_destroy(global.currentPlayer)
global.currentPlayer = id
global.PlayerHighlightExisits = true
obj_Player_Highlight.knifeOut = false
hp = max_hp;

// Reset state machine so it doesn't fire while player-controlled
state = TERMITESTATE.FREE;

// Update camera
if (instance_exists(obj_Camera)) {
    obj_Camera.follow_target = id;
}
