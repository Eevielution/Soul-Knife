// deal with enemies that are not players
with(other) {
	if (other.isPlayer){
		hp = hp - 5;
	}
}