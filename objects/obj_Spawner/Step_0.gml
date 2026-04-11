// Watch for all non-player enemies to die, then queue the next spawn
if (!waiting_for_death) exit;
if (alarm[0] > 0) exit; // already counting down

var _non_player_rats = 0;
with (obj_Rat_Enemy) {
    if (!isPlayer) _non_player_rats++;
}

if (_non_player_rats == 0) {
    // All enemies gone — start the respawn timer
    alarm[0] = respawn_delay;
    waiting_for_death = false;
}
