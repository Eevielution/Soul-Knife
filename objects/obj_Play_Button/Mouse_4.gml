// Inherit the parent event
event_inherited();

// HTML5 blocks audio autoplay until a user gesture fires.
// The Play button click IS that gesture, so retry music here if Game Start was blocked.
if (!variable_global_exists("bgm_inst") || !audio_is_playing(global.bgm_inst)) {
    global.bgm_inst = audio_play_sound(bgm_Main_Theme_2_22_26, 1, true);
}

//logic for procedural room generation eventually???
room_goto(rm_16x9);
instance_destroy(inst_71DBF5A3);
instance_destroy(b);
