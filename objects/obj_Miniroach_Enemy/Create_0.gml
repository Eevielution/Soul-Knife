/// @description Establish key vars
event_inherited(); // defines collision() from obj_Movement_Parent
depth = -1; // same as obj_Player, in front of highlight

isPlayer = false
isOriginal = false
isMiniroach = true
image_xscale = 1/2
image_yscale = 1/2
speed = 1
direction = point_direction(x, y, obj_Roach_Enemy.x, obj_Roach_Enemy.y) + 180
image_angle = direction + 180

max_hp = 10;
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

