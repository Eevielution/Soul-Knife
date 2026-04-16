/// @description Establish key vars
depth = -1; // same as obj_Player, in front of highlight

isPlayer = false

max_hp = 10;
hp = max_hp;

hsp = (random(3) - 1)
vsp = (random(3) - 1)

// state machine for the attack pattern
state = TERMITESTATE.FREE;
dash_flag = false;
timeToMove = 50
isAttackActive = true;
dash_direction = 0; // default to right dash
affectedByTermiteAttack = ds_list_create();

enum TERMITESTATE {
	FREE,
	ATTACK_DASH,
	COLLIDE
}