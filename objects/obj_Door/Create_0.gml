depth = 100;

// loc_name is set per-instance via creation code
// -1 means unassigned; rooms should always assign this
if (!variable_instance_exists(id, "loc_name")) {
    loc_name = -1;
}
