view_enabled    = true;
view_visible[0] = true;

view_camera[0]  = cam;

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

