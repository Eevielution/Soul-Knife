// Room Start — spawn immediately if no enemies exist anywhere in the room
// The very first room is always safe — don't spawn anything
global.rooms_visited++;
if (global.rooms_visited <= 1) exit;

var _enemy_count = 0;
with (obj_Rat_Enemy) {
    if (!isPlayer) _enemy_count++;
}
with (obj_Termite_Enemy) {
    if (!isPlayer) _enemy_count++;
}

if (_enemy_count == 0) {
    // Spawn right now
    alarm[0] = 1;
    waiting_for_death = false;
} else {
    // Enemies already here — wait for them to die before taking over
    waiting_for_death = true;
}
