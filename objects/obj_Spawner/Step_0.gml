if (!waiting_for_death) exit;
if (alarm[0] > 0) exit;

// Exit early as soon as any live non-player enemy is found
for (var i = 0; i < array_length(enemy_types); i++) {
    with (enemy_types[i]) {
        if (!isPlayer) exit;
    }
}

// No live non-player enemies found — trigger respawn
alarm[0] = respawn_delay;
waiting_for_death = false;