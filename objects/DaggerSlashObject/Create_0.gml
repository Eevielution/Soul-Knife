centerX = global.currentPlayer.x + global.currentPlayer.sprite_width / 2
centerY = global.currentPlayer.y + global.currentPlayer.sprite_height / 2
currentDirection = point_direction(centerX, centerY, mouse_x, mouse_y);
image_angle = currentDirection - 90;
alarm[0] = 10;