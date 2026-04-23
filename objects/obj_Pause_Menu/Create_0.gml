// Freeze all gameplay objects; only this instance keeps running
instance_deactivate_all(true);

// panel: 0=minimap/default  1=settings  2=controls
panel   = 0;
hovered = 0; // 0=Resume  1=Settings  2=Controls  3=Quit

// Slider values mirror the globals so changes are discardable if needed
sl_master = global.vol_master;
sl_sfx    = global.vol_sfx;
sl_bgm    = global.vol_bgm;

// Which slider is being dragged (-1 = none)
dragging = -1;
