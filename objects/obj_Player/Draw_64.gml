/// @desc Health Bar

//draw_sprite(spr_Health_bar, 0, healthbar_x, healthbar_y);
draw_sprite_stretched(spr_Health_bar, 0, healthbar_x, healthbar_y, (hp/max_hp) * healthbar_width, healthbar_height);