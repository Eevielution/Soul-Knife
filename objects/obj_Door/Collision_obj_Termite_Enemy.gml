// Only trigger for the player-controlled termite, not enemy termites
if (!other.isPlayer) exit;

var opp_sides = [1, 0, 3, 2];
global.entry_door_side = opp_sides[loc_name];

var candidates;
switch (global.entry_door_side) {
    case 0: candidates = [rm_16x9, rm_16x18, rm_18x32]; break;
    case 1: candidates = [rm_16x9, rm_16x18, rm_18x32, rm_L]; break;
    case 2: candidates = [rm_16x9, rm_16x18, rm_18x32]; break;
    case 3: candidates = [rm_16x9, rm_16x18, rm_18x32, rm_L]; break;
    default:
        show_debug_message("obj_Door: invalid loc_name " + string(loc_name));
        exit;
}

var pick = candidates[irandom(array_length(candidates) - 1)];
audio_play_sound(snd_door, 1, false);
global.player_hp = global.currentPlayer.hp;
room_goto(pick);
