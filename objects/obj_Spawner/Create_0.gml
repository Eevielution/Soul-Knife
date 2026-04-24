visible = false;

respawn_delay = 300; // ticks after last enemy dies before next spawn (~5s at 60fps)
waiting_for_death = false;

// Central enemy list
enemy_types = [
    obj_Rat_Enemy,
    obj_Termite_Enemy,
    obj_Roach_Enemy
];

// Don't start alarm here — Room Start handles the first spawn check