application_surface_draw_enable(false);

var camera = view_get_camera(0);
var cw = camera_get_view_width(camera);
var ch = camera_get_view_height(camera);
light_surface = surface_create(cw,ch);