// The game over screen is now shown for 3 seconds before restarting.
// obj_Camera (persistent) sets the restart timer in its Room Start event.
// Explicitly restore surface drawing in case obj_Lighting left it disabled.
application_surface_draw_enable(true);