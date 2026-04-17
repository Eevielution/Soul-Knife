// Watch for all non-player enemies to die, then queue the next spawn
if (!waiting_for_death) exit;
if (alarm[0] > 0) exit; // already counting down

var _enemy_count = 0;
with (obj_Rat_Enemy) {
    if (!isPlayer) _enemy_count++;
}
with (obj_Termite_Enemy) {
    if (!isPlayer) _enemy_count++;
}

if (_enemy_count == 0) {
    // All enemies gone — start the respawn timer
    alarm[0] = respawn_delay;
    waiting_for_death = false;
}
