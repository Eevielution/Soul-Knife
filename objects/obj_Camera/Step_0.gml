// ── Pause menu trigger ─────────────────────────────────────────────────────
if (keyboard_check_pressed(vk_escape)
    && instance_exists(obj_Player_Highlight)
    && !instance_exists(obj_Pause_Menu)) {
    instance_create_layer(0, 0, "Instances", obj_Pause_Menu);
    exit;
}

if (!instance_exists(follow_target)) {
    if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
        follow_target = global.currentPlayer;
    } else if (instance_exists(obj_Player)) {
        follow_target = instance_find(obj_Player, 0);
    } else {
        exit;
    }

    // Target was reacquired (often after transforms/room changes):
    // snap internal state so the camera does not lerp from stale coordinates.
    cam_x = follow_target.x;
    cam_y = follow_target.y;
    target_x = cam_x;
    target_y = cam_y;
}

if (!camera_locked && instance_exists(follow_target)) {

    var ideal_x = follow_target.x;
    var ideal_y = follow_target.y;

    if (lead_amount > 0) {
        var target_lead_x = 0;
        var target_lead_y = 0;

        if (variable_instance_exists(follow_target, "hsp") && variable_instance_exists(follow_target, "vsp")) {
            var _fhsp = variable_instance_get(follow_target, "hsp");
            var _fvsp = variable_instance_get(follow_target, "vsp");
            target_lead_x = sign(_fhsp) * lead_amount;
            target_lead_y = sign(_fvsp) * lead_amount;
        }

        lead_x = lerp(lead_x, target_lead_x, lead_smoothing);
        lead_y = lerp(lead_y, target_lead_y, lead_smoothing);
        ideal_x += lead_x;
        ideal_y += lead_y;
    }

    if (use_deadzone) {
        if (ideal_x < target_x - deadzone_width  * 0.5) target_x = ideal_x + deadzone_width  * 0.5;
        else if (ideal_x > target_x + deadzone_width  * 0.5) target_x = ideal_x - deadzone_width  * 0.5;
        if (ideal_y < target_y - deadzone_height * 0.5) target_y = ideal_y + deadzone_height * 0.5;
        else if (ideal_y > target_y + deadzone_height * 0.5) target_y = ideal_y - deadzone_height * 0.5;
    } else {
        target_x = ideal_x;
        target_y = ideal_y;
    }

    if (in_camera_zone) {
        target_x = zone_target_x;
        target_y = zone_target_y;
        current_follow_speed = zone_lerp_speed;
    } else {
        var dist = point_distance(cam_x, cam_y, target_x, target_y);
        var speed_target = (dist > 50) ? follow_speed_fast : follow_speed;
        current_follow_speed = lerp(current_follow_speed, speed_target, follow_acceleration);
    }
}

if (!camera_locked) {
    cam_x = lerp(cam_x, target_x, current_follow_speed);
    cam_y = lerp(cam_y, target_y, current_follow_speed);
}

var half_w = (cam_width  / zoom_level) * 0.5;
var half_h = (cam_height / zoom_level) * 0.5;

cam_x = clamp(cam_x, bound_left   + half_w, bound_right  - half_w);
cam_y = clamp(cam_y, bound_top    + half_h, bound_bottom - half_h);
target_x = clamp(target_x, bound_left + half_w, bound_right  - half_w);
target_y = clamp(target_y, bound_top  + half_h, bound_bottom - half_h);

if (zoom_level != target_zoom) {
    zoom_level = lerp(zoom_level, target_zoom, zoom_speed);
    camera_set_view_size(cam, cam_width / zoom_level, cam_height / zoom_level);
}

prev_x = cam_x;
prev_y = cam_y;
