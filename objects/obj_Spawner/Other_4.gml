// Room Start — spawn immediately if no enemies exist anywhere in the room
var _non_player_rats = 0;
with (obj_Rat_Enemy) {
    if (!isPlayer) _non_player_rats++;
}

if (_non_player_rats == 0) {
    // Spawn right now
    alarm[0] = 1;
    waiting_for_death = false;
} else {
    // Enemies already here — wait for them to die before taking over
    waiting_for_death = true;
}
