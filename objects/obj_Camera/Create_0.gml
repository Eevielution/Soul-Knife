if (instance_number(obj_Camera) > 1) {
    instance_destroy();
    exit;
}

cam_width  = 320;
cam_height = 180;

viewport_width  = 1280;
viewport_height = 720;

cam_x = 0;
cam_y = 0;

target_x = cam_x;
target_y = cam_y;

follow_target = noone;

follow_speed      = 0.05;
follow_speed_fast = 0.08;
follow_acceleration = 0.8;
current_follow_speed = follow_speed;

lead_amount    = 12;
lead_smoothing = 0.1;
lead_x = 0;
lead_y = 0;

use_deadzone     = false;
deadzone_width   = 40;
deadzone_height  = 30;

clamp_to_room = true;
bound_left   = 0;
bound_top    = 0;
bound_right  = room_width;
bound_bottom = room_height;

zoom_level  = 1.0;
target_zoom = 1.0;
zoom_speed  = 0.1;

camera_locked  = false;
in_camera_zone = false;
zone_target_x  = 0;
zone_target_y  = 0;
zone_lerp_speed = 0.1;

transitioning = false;

offset_x = 0;
offset_y = 0;

prev_x = cam_x;
prev_y = cam_y;

camera_debug_mode = false;

view_enabled    = true;
view_visible[0] = true;

// Always create a fresh camera via camera_create() so it is NOT auto-destroyed
// when leaving a room (room-assigned cameras in view_camera[0] are destroyed on room change).
cam = camera_create();
// Set size and position BEFORE assigning to view_camera[0].
// HTML5 crashes on the very first render if the camera has no size defined.
// Use full viewport size here (main menu, no zoom); Room Start re-applies
// the correct zoom size when entering game rooms.
camera_set_view_size(cam, viewport_width, viewport_height);
camera_set_view_pos(cam, 0, 0);
view_camera[0] = cam;

view_set_wport(0, viewport_width);
view_set_hport(0, viewport_height);

gpu_set_tex_filter(false);
alarm[0] = 1;

if (instance_exists(obj_Player)) {
    follow_target = instance_find(obj_Player, 0);
    cam_x = follow_target.x;
    cam_y = follow_target.y;
} else {
    cam_x = room_width  * 0.5;
    cam_y = room_height * 0.5;
}
target_x = cam_x;
target_y = cam_y;

bound_right  = room_width;
bound_bottom = room_height;
