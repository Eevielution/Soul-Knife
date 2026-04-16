/// @description Origin-point push-out — only applies to the current player

if (!variable_global_exists("currentPlayer") || !instance_exists(global.currentPlayer)) exit;

var tx1 = bbox_left;
var ty1 = bbox_top;
var tx2 = bbox_right;
var ty2 = bbox_bottom;

var _p = global.currentPlayer;

// Only act when the player's origin point is inside this solid
if (!point_in_rectangle(_p.x, _p.y, tx1, ty1, tx2, ty2)) exit;

// If touching a door, let it pass through
if (place_meeting(_p.x, _p.y, obj_Door)) exit;

// Push origin to the nearest edge
with (_p) {
    var dist_left  = x  - tx1;
    var dist_right = tx2 - x;
    var dist_top   = y  - ty1;
    var dist_bot   = ty2 - y;

    if (min(dist_left, dist_right) < min(dist_top, dist_bot)) {
        if (dist_left < dist_right) {
            x = tx1;
        } else {
            x = tx2;
        }
    } else {
        if (dist_top < dist_bot) {
            y = ty1;
        } else {
            y = ty2;
        }
    }
}
