var display_w = display_get_width();
var display_h = display_get_height();
var center_x  = (display_w - window_get_width())  / 2;
var center_y  = (display_h - window_get_height()) / 2;
window_set_position(center_x, center_y);
