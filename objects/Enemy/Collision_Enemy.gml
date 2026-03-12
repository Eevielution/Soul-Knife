// deal with enemies that are not players
with(other) {
	if (other.isPlayer){
		other.hp = other.hp - 1;
		if (other.hp <= 0) {
			instance_destroy(other);
		}
	}
}