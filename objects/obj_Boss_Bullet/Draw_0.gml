// Rotate bullet to face its direction of travel.
// Assumes spr_Centipede_Bullet faces upward in the sprite sheet.
// If bullet appears 90° off, change the angle offset (-90) to 0 or 90.
// Set bullet sprite origin to center (4, 5) in the GMS2 sprite editor.
draw_sprite_ext(spr_Centipede_Bullet, 0, x, y, 1, 1, direction - 90, c_white, 1);
