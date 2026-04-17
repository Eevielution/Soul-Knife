if (self.isAttackActive) {
	if (other.hit_cooldown <= 0) {
		other.hp -= 10;
		other.hit_cooldown = 60;
	}
	self.isAttackActive = false;
	alarm[0] = 60;
}
