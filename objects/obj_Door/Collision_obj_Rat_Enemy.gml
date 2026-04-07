show_debug_message("door object is hit by player")
if (other.isPlayer) {
	if (loc_name == 0) {
		global.currentPlayer.x = 160;
		global.currentPlayer.y = 150;
	} else if (loc_name == 1) {
		global.currentPlayer.x = 160;
		global.currentPlayer.y = 40;
	} else if (loc_name == 2) {
		global.currentPlayer.x = 266;
		global.currentPlayer.y = 90;
	} else if (loc_name == 3) {
		global.currentPlayer.x = 55;
		global.currentPlayer.y = 90;
	}
}