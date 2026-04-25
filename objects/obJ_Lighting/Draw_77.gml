// Use stretched draw so the scene fills the full GUI/canvas in HTML5 too
draw_surface_stretched(application_surface, 0, 0, display_get_gui_width(), display_get_gui_height());

// Multiply blend: light_surface (black=dark, white=lit) * scene = correct lighting
// Works cross-platform including HTML5/WebGL
gpu_set_blendmode_ext(bm_dest_colour, bm_zero);
// Use GUI dimensions — more reliable than window_get_width/height in HTML5
draw_surface_stretched(self.light_surface, 0, 0, display_get_gui_width(), display_get_gui_height());
gpu_set_blendmode(bm_normal);