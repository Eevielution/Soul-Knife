// No follow target means a static-view room (e.g. main menu).
// Room Start already set camera_set_view_pos to the correct position — don't override it.
if (follow_target == noone) exit;

var view_w = cam_width  / zoom_level;
var view_h = cam_height / zoom_level;

var view_x = cam_x - view_w * 0.5 + offset_x;
var view_y = cam_y - view_h * 0.5 + offset_y;

view_x = clamp(view_x, 0, max(0, room_width  - view_w));
view_y = clamp(view_y, 0, max(0, room_height - view_h));

camera_set_view_pos(cam, view_x, view_y);
