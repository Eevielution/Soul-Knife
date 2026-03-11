if (other.id != global.currentPlayer) { // can occasionally lag game if knife hits player
	instance_destroy(global.currentPlayer); 
	instance_destroy();
	global.SoulKnifeExists = false; 
}

