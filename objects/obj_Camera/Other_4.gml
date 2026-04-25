view_enabled    = true;
view_visible[0] = true;
view_camera[0]  = cam;

// Game over room: display the full room for 3 seconds, then restart.
// obj_Lighting is not present here so we must re-enable surface drawing manually.
if (room == rm_Game_Over) {
    application_surface_draw_enable(true);
    camera_set_view_size(cam, room_width, room_height);
    camera_set_view_pos(cam, 0, 0);
    view_set_wport(0, room_width);
    view_set_hport(0, room_height);
    follow_target = noone;
    alarm[0] = 180; // 3 seconds at 60 fps — Alarm_0 calls game_restart()
    exit;
}

// Normal game room setup
camera_set_view_size(cam, cam_width / zoom_level, cam_height / zoom_level);
camera_set_view_target(cam, noone);
view_set_wport(0, viewport_width);
view_set_hport(0, viewport_height);

bound_left   = 0;
bound_top    = 0;
bound_right  = room_width;
bound_bottom = room_height;

if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
    follow_target = global.currentPlayer;
    lead_x = 0;
    lead_y = 0;
} else if (instance_exists(obj_Player)) {
    follow_target = obj_Player;
    lead_x = 0;
    lead_y = 0;
}

