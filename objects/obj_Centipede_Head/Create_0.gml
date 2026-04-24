max_hp       = 60;
hp           = max_hp;
hit_cooldown = 0;

// Orbit: head circles the room center. Speed ramps up as HP drops.
orbit_angle  = 0;   // degrees; increments each step
orbit_speed  = 1.2; // degrees/step at full HP — scales to 2.8 at death
orbit_radius = min(room_width, room_height) * 0.35;

// Position-history circular buffer — segments read delayed positions from this.
var _hist_size = 256;
pos_history_x = array_create(_hist_size, x);
pos_history_y = array_create(_hist_size, y);
history_head  = 0;       // next write slot (increments each step)
max_history   = _hist_size;

// Segment chain setup
num_segments    = 10;
segment_spacing = 16; // frames of history between adjacent segments

segment_list = ds_list_create();
for (var _i = 0; _i < num_segments; _i++) {
    var _seg            = instance_create_layer(x, y, "Instances", obj_Centipede_Segment);
    _seg.head_id        = id;
    _seg.segment_index  = _i;                        // 0 = closest to head
    _seg.history_offset = (_i + 1) * segment_spacing;
    _seg.fire_timer     = 120 + _i * 18;             // stagger so they don't all fire at once
    ds_list_add(segment_list, _seg);
}
