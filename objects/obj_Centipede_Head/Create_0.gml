max_hp       = 60;
hp           = max_hp;
hit_cooldown = 0;

// Cardinal movement
head_dir = choose(0, 180);
move_spd = 0.5;
turn_cd  = 60;

// Frame-based position history — one entry written every step.
// At speed 1.5–3.0 px/step × 6-frame spacing = 9–18 px between segment centers,
// keeping 16×16 sprites visually connected at all speeds, and the head is
// always flush against segment 1 (only 1 frame behind = 1.5–3 px).
var _hist_size = 256;
pos_history_x = array_create(_hist_size, x);
pos_history_y = array_create(_hist_size, y);
history_head  = 0;
max_history   = _hist_size;

num_segments    = 10;
segment_spacing = 6; // frames of delay between adjacent segments

segment_list = ds_list_create();
for (var _i = 0; _i < num_segments; _i++) {
    var _seg            = instance_create_layer(x, y, "Instances", obj_Centipede_Segment);
    _seg.head_id        = id;
    _seg.segment_index  = _i;
    _seg.history_offset = (_i + 1) * segment_spacing;
    _seg.fire_timer     = 120 + _i * 18;
    ds_list_add(segment_list, _seg);
}

// Pre-fill all history slots so segments start in a straight line behind the head.
// With history_head=0, a segment with offset k reads slot (max_history - 1 - k).
for (var _j = 0; _j < _hist_size; _j++) {
    var _slot = (_hist_size - 1 - _j + _hist_size) mod _hist_size;
    pos_history_x[_slot] = x - lengthdir_x(_j * move_spd, head_dir);
    pos_history_y[_slot] = y - lengthdir_y(_j * move_spd, head_dir);
}


image_speed = 6;