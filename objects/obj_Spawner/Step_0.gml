if (!waiting_for_death) exit;
if (alarm[0] > 0) exit;

var _enemy_count = 0;

for (var i = 0; i < array_length(enemy_types); i++) {
    var _type = enemy_types[i];

    with (_type) {
        if (!isPlayer) _enemy_count++;
    }
}

if (_enemy_count == 0) {
    alarm[0] = respawn_delay;
    waiting_for_death = false;
}