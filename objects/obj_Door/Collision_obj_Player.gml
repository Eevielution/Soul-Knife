// loc_name: 0=top, 1=bottom, 2=left, 3=right
// When the player walks through this door they enter the next room from the OPPOSITE side.
// Opposite pairs: top(0)<->bottom(1), left(2)<->right(3)
var opp_sides = [1, 0, 3, 2];
global.entry_door_side = opp_sides[loc_name];

// Select a random room that contains the required entry door
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
room_goto(pick);
