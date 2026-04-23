// Only the player-termite damages the boss head via dash
if (!other.isPlayer) exit;
if (other.state != TERMITESTATE.ATTACK_DASH) exit;
if (hit_cooldown > 0) exit;

hp           -= 8;
hit_cooldown  = 20;

// Bounce the termite back the same way it bounces off walls
with (other) {
    hspeed = 0;
    vspeed = 0;
    state  = TERMITESTATE.COLLIDE;
}
