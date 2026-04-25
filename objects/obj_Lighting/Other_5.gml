// Room End — restore automatic surface drawing so rooms without obj_Lighting
// (main menu, game over) render correctly.
application_surface_draw_enable(true);

// Free the light surface to avoid GPU memory leaks (especially important in HTML5)
if (surface_exists(light_surface)) {
    surface_free(light_surface);
}
