with(other) {
	if (hp <= 0) {
		check();
	}
	hp = hp - 1
}
function check() {
	if (other.id != global.currentPlayer) { // can occasionally lag game if knife hits player
		instance_destroy(global.currentPlayer); 
		//instance_destroy(); // Jose' note: deletes enemy we transfer into
		global.SoulKnifeExists = false; 
	}
}
