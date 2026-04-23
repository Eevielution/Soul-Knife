if (hit_cooldown > 0) exit;
hp           -= 10;
hit_cooldown  = 20;
if (hp <= 0) instance_destroy();
