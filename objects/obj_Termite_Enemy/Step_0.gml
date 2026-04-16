switch (state) {
	case TERMITESTATE.FREE: TermiteState_Free(); break;
	case TERMITESTATE.ATTACK_DASH: TermiteState_Attack_Dash(); break;
	case TERMITESTATE.COLLIDE: TermiteState_Collide(); break;
	
}