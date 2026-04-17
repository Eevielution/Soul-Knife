/// @description Establish key vars
event_inherited(); // defines collision() from obj_Movement_Parent
depth = -1; // same as obj_Player, in front of highlight

isPlayer = false
isTermite = true

hsp = 0
vsp = 0
bleed_rate = 1/120 // 1 HP every 2 seconds while player-controlled

max_hp = 10;
hp = max_hp;
immunity = false

hit_cooldown = 0

// state machine for the attack pattern
beforeAttack_x = x
beforeAttack_y = y
state = TERMITESTATE.FREE;
dash_flag = false;
timeToMove = 50
isAttackActive = true;
dash_direction = 0; // default to right dash
enum TERMITESTATE {
	FREE,
	ATTACK_DASH,
	COLLIDE
}
