if (hp > 0 && !immunity && !(id == global.currentPlayer))
{
   hp -= 5
   immunity = true
   alarm[1] = 30
}
function check()
{
	if (other.id != global.currentPlayer)
	{
		instance_destroy(global.currentPlayer); 
		global.PlayerHighlightExisits = false; 
	}
}
