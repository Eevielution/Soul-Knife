if (hp > 0 && !immunity && !(id == global.currentPlayer))
{
    hp -= 5
    immunity = true
    alarm[1] = 30
}
