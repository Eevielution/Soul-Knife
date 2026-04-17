// Player-termite deals damage to enemy rats during attack lunge.
// The rat's own immunity timer (alarm[1] = 30 frames) caps damage to one hit per dash.
if (!isPlayer) exit;
if (state != TERMITESTATE.ATTACK_DASH) exit;
if (other.isPlayer) exit;     // never damage the player-rat
if (other.immunity) exit;

other.hp -= 10;
other.immunity = true;
other.alarm[1] = 30;
