// Destroy when outside the room boundaries
if (x < -8 || x > room_width + 8 || y < -8 || y > room_height + 8) {
    instance_destroy();
    exit;
}

// Hit the current player (works for all forms: human, rat, termite)
if (variable_global_exists("currentPlayer") && instance_exists(global.currentPlayer)) {
    var _p = global.currentPlayer;
    if (point_distance(x, y, _p.x, _p.y) < 12) {
        if (_p.hit_cooldown <= 0) {
            _p.hp         -= 5;
            _p.hit_cooldown = 60;
            if (_p.hp <= 0) global.killed_by_boss = true;
        }
        instance_destroy();
        exit;
    }
}
