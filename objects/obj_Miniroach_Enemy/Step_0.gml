if (!instance_exists(obj_Player_Highlight)) exit;
point = angle_difference(direction, point_direction(x, y, obj_Player_Highlight.x, obj_Player_Highlight.y))
if(point < 5 && point < 180)
{
	direction ++
}
else if(point > -5 && point > -180)
{
	direction --
}
else
{
	direction = point_direction(x, y, obj_Player_Highlight.x, obj_Player_Highlight.y) + 180
}
image_angle = direction + 180