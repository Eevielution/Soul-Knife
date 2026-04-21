var camera = view_get_camera(0);

if(!surface_exists(self.light_surface)){
	
	var cw = camera_get_view_width(camera);
	var ch = camera_get_view_height(camera);
	self.light_surface = surface_create(cw,ch);
}

surface_set_target(self.light_surface);


draw_clear(c_black);
camera_apply(camera);
gpu_set_blendmode(bm_subtract);
var scale = 1;
with (obj_torch){
	draw_sprite_ext(spr_Torch_Light, 0, self.x,self.y, scale, scale, 0, c_white, 1);
}
gpu_set_blendmode(bm_normal);



surface_reset_target();