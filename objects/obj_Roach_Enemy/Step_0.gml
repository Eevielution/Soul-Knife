if(global.roachKill >= 15)
{
	var _cp = global.currentPlayer;
	if (_cp.object_index == obj_Rat_Enemy || _cp.object_index == obj_Termite_Enemy || _cp.object_index == obj_Miniroach_Enemy) {
	    global.human_hp = min(global.human_hp + 10, 50);
	} else {
	    _cp.hp = min(_cp.hp + 10, _cp.max_hp);
	}
	global.creatures_slain++;
	instance_destroy()
}