// Draw the rock sprite offset by the shake amount for hit feedback
draw_sprite_ext(sprite_index, image_index, x + shake_x, y + shake_y,
                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
