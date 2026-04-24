var camera = view_get_camera(0);

if(!surface_exists(self.light_surface)){
	var cw = camera_get_view_width(camera);
	var ch = camera_get_view_height(camera);
	light_surface = surface_create(cw,ch);

}
surface_set_target(self.light_surface);

draw_clear(c_black);
camera_apply(camera);
gpu_set_blendmode(bm_subtract);
var scalex;
var scaley;

if (self.timer > 0)
{
    self.timer -= 1;
	scalex = 1;
	scaley = 1;
} else {
	self.timer = 25;
	scalex = random_range(0.75,1.0);
	scaley = random_range(0.75,1.0);
	
}
//var scale = 1;
with (obj_Torch){
	if image_angle == 90 and x < 64 {
		draw_sprite_ext(spr_Torch_Light, 0, x - 12, y + 16,scalex,scaley, 90 ,c_white, 1);
	} else if image_angle == 90 and x > 64 {
		draw_sprite_ext(spr_Torch_Light, 0, x + 13, y - 16,scalex,scaley, 270, c_white, 1);
	} else {
		if y < 64 {
			draw_sprite_ext(spr_Torch_Light, 0, x - 15, y - 10,scalex,scaley, 0,c_white, 1);
		} else {
			draw_sprite_ext(spr_Torch_Light, 0, x + 17 , y + 15, scalex,scaley, 180,c_white, 1);
		}
	}
}
gpu_set_blendmode(bm_normal);

surface_reset_target();
