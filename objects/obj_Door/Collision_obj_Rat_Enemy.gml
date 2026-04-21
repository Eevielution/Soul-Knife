// Only trigger for the player-controlled rat, not enemy rats
if (!other.isPlayer) exit;

// Same door-transition logic as Collision_obj_Player
var opp_sides = [1, 0, 3, 2];
global.entry_door_side = opp_sides[loc_name];

var candidates;
switch (global.entry_door_side) {
    case 0: // TOP door
        candidates = [rm_16x9, rm_16x18, rm_18x32];
        break;
    case 1: // BOTTOM door
        candidates = [rm_16x9, rm_16x18, rm_18x32, rm_L];
        break;
    case 2: // LEFT door
        candidates = [rm_16x9, rm_16x18, rm_18x32];
        break;
    case 3: // RIGHT door
        candidates = [rm_16x9, rm_16x18, rm_18x32, rm_L];
        break;
    default:
        show_debug_message("obj_Door: invalid loc_name " + string(loc_name));
        exit;
}

var pick = candidates[irandom(array_length(candidates) - 1)];
global.player_hp = global.currentPlayer.hp; // persist HP across room
if (!instance_exists(obj_Transition)) {
    audio_play_sound(snd_door, 1, false);
    global.transition_room = pick;
    instance_create_layer(0, 0, "Instances", obj_Transition);
}