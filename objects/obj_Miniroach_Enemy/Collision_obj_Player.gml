// Damage the player once per second (hit_cooldown prevents per-frame instakill)
if (other.hit_cooldown > 0) exit;
other.hp -= 7;
other.hit_cooldown = 30;
instance_destroy()