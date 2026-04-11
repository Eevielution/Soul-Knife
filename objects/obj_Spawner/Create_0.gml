visible = false;

respawn_delay = 300; // ticks after last enemy dies before next spawn (~5s at 60fps)
waiting_for_death = false; // true once we've spawned and are watching for enemies to die

// Don't start alarm here — Room Start handles the first spawn check
