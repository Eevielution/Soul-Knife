head_id        = noone; // set by head immediately after instance_create_layer
segment_index  = 0;     // set by head (0 = nearest to head)
history_offset = 16;    // set by head

max_hp       = 15;
hp           = max_hp;
hit_cooldown = 0;

// fire_timer is also overridden by the head to stagger each segment
fire_timer    = 120;
fire_interval = 180; // base value; actual interval is chosen from head's HP each shot

open_timer    = 0;   // frames remaining in the "open" firing flash
open_duration = 25;
