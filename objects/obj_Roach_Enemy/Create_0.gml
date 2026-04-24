/// @description Establish key vars
event_inherited(); // defines collision() from obj_Movement_Parent
depth = -1; // same as obj_Player, in front of highlight

isPlayer = false
isOriginal = false
isRoach = true

max_hp = 4;
hp = max_hp;
bleed_rate = 1/120 // inherited by player-rat
immunity = false
attacking = false
frame_attack = 0
hit_cooldown = 0

timer = 0
timerStop = random(100) + 50
hsp = (random(3) - 1)
vsp = (random(3) - 1)
// global.roachKill is initialized in Game Start (obj_Audio_Controller Other_2), not here

alarm[1] = 1

image_xscale = 0.5; 
image_yscale = 0.5;
