// Player-termite deals damage to other termites during attack lunge.
// The target's immunity timer (alarm[1] = 30 frames) caps damage to one hit per dash.
if (!isPlayer) exit;
if (state != TERMITESTATE.ATTACK_DASH) exit;
if (other.isPlayer) exit;     // don't damage a player-termite (shouldn't happen)
if (other.immunity) exit;

other.hp -= 10;
other.immunity = true;
other.alarm[1] = 30;
