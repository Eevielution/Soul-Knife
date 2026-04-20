// Damage from rat attack lunge (player-rat and enemy rat alike)
if (!other.attacking) exit;
if (destroyed) exit;
if (hit_cooldown > 0) exit;

hits_taken++;
hit_cooldown = 45;
shake_timer = shake_duration;

if      (hits_taken == 1) sprite_index = spr_Rock_Minor_Crack;
else if (hits_taken == 2) sprite_index = spr_Rock_Major_Crack;
else if (hits_taken == 3) sprite_index = spr_Rock_Chunked;
else if (hits_taken >= 4) {
    destroyed    = true;
    sprite_index = spr_Rock_Pieces;
}
