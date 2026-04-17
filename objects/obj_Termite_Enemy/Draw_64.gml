scale = 1.5
draw_sprite_ext(spr_Icon_Health, 0, 10, 10, scale, scale, 0, c_white, 1);

icon_scale = 1.2
if (global.currentPlayer.object_index == obj_Termite_Enemy) {
	draw_sprite_ext(spr_Termite_Icon, 0, 65, 60, icon_scale, icon_scale, 0, c_white, 1);
}
