global.bgm_inst = audio_play_sound(bgm_Main_Theme_2_22_26, 1, true);

// Initialize globals
global.entry_door_side  = -1; // -1 = no active transition; 0=top, 1=bottom, 2=left, 3=right
global.player_hp        = -1; // -1 = unset (first room uses max_hp)
global.human_hp         = 50; // saved human HP when transforming into a rat
global.rooms_visited    = 0;  // 0 = first (safe) room
global.creatures_slain  = 0;  // total enemy kills (not transforms)
global.transition_room  = -1; // target room for the next transition
global.boss_countdown   = irandom_range(5, 10); // rooms until the centipede boss spawns

// Volume globals (0.0 – 1.0)
global.vol_master = 1.0;
global.vol_sfx    = 1.0;
global.vol_bgm    = 1.0;