// HP bar moved to obj_Player_Highlight Draw_64.gml
// (obj_Camera is invisible so its Draw GUI events never fire)

if (!camera_debug_mode) exit;

draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(10, 10, 300, 170, false);
draw_set_alpha(1);
draw_set_color(c_lime);

var lh = 16;
var sy = 15;
var l  = 0;

draw_text(15, sy + (l++) * lh, "=== CAMERA DEBUG ===");
draw_text(15, sy + (l++) * lh, "Pos: "    + string(cam_x) + ", " + string(cam_y));
draw_text(15, sy + (l++) * lh, "Target: " + string(target_x) + ", " + string(target_y));
draw_text(15, sy + (l++) * lh, "Speed: "  + string_format(current_follow_speed, 1, 3));
draw_text(15, sy + (l++) * lh, "Zoom: "   + string_format(zoom_level, 1, 2) + "x");
draw_text(15, sy + (l++) * lh, "Locked: " + (camera_locked  ? "YES" : "NO"));
draw_text(15, sy + (l++) * lh, "Zone: "   + (in_camera_zone ? "YES" : "NO"));

if (instance_exists(follow_target)) {
    draw_text(15, sy + (l++) * lh, "Following: obj_Player @ "
        + string(follow_target.x) + ", " + string(follow_target.y));
} else {
    draw_text(15, sy + (l++) * lh, "Following: NONE");
}

draw_set_alpha(1);
draw_set_color(c_white);
