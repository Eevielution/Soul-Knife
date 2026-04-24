max_hp       = 60;
hp           = max_hp;
hit_cooldown = 0;

// Cardinal movement
head_dir = choose(0, 180);
move_spd = 1.5;
turn_cd  = 60;

// Distance-based position history: a new entry is written every segment_step_dist px.
// This keeps body spacing pixel-perfect regardless of speed.
segment_step_dist = 14; // pixels between history entries (≈ sprite width)
last_hist_x       = x;
last_hist_y       = y;

var _hist_size = 512;
pos_history_x = array_create(_hist_size, x);
pos_history_y = array_create(_hist_size, y);
history_head  = 0;
max_history   = _hist_size;

num_segments    = 10;
segment_spacing = 1; // 1 history-entry per gap = segment_step_dist px between segments

segment_list = ds_list_create();
for (var _i = 0; _i < num_segments; _i++) {
    var _seg            = instance_create_layer(x, y, "Instances", obj_Centipede_Segment);
    _seg.head_id        = id;
    _seg.segment_index  = _i;
    _seg.history_offset = (_i + 1) * segment_spacing; // = _i + 1
    _seg.fire_timer     = 120 + _i * 18;
    ds_list_add(segment_list, _seg);
}

// Pre-fill history so segments start in a straight line behind the head
// instead of piling at the spawn point.
// With history_head=0, a segment with offset k reads slot (max_history - 1 - k).
for (var _j = 0; _j <= num_segments; _j++) {
    var _slot = (max_history - 1 - _j + max_history) mod max_history;
    pos_history_x[_slot] = x - lengthdir_x(_j * segment_step_dist, head_dir);
    pos_history_y[_slot] = y - lengthdir_y(_j * segment_step_dist, head_dir);
}
