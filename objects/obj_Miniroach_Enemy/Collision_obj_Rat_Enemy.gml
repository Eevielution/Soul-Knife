// Enemy roach hit the player-rat
if (!other.isPlayer) exit;
if (other.immunity) exit;
other.hp -= 1;
other.immunity = true;
other.alarm[1] = 30;
instance_destroy()