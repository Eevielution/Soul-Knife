// Safety guard — only run if a valid target room has been set
if (!variable_global_exists("transition_room") || global.transition_room == -1) {
    instance_destroy();
    exit;
}

switch (phase) {
    case 0: // fade to black
        alpha += fade_speed;
        if (alpha >= 1) {
            alpha = 1;
            phase = 1;
        }
        break;

    case 1: // switch to target room on the step after reaching full black
        room_goto(global.transition_room);
        phase = 2;
        break;

    case 2: // fade from black in the new room
        alpha -= fade_speed;
        if (alpha <= 0) {
            alpha = 0;
            persistent = false;
            instance_destroy();
        }
        break;
}
