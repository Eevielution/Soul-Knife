// Free the segment ds_list if the death handler didn't already do it
if (ds_exists(segment_list, ds_type_list)) {
    ds_list_destroy(segment_list);
}
