if (isPlayer) {
    // Player-rat hit an enemy — only deal damage during the lunge (attacking)
    if (!attacking) exit;
    if (other.immunity) exit;
    other.hp -= 5;
    other.immunity = true;
    other.alarm[1] = 30;
} else {
    // Enemy rat hit the player-termite
    if (!other.isPlayer) exit;
    if (other.immunity) exit;
    other.hp -= 1;
    other.immunity = true;
    other.alarm[1] = 60;
}