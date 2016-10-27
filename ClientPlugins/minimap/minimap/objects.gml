// OBJECTS

// Objects displayed by the minimap
global.yb_minimap_displayables = ds_list_create();
global.yb_minimap_displayable = object_add();
object_set_depth(global.yb_minimap_displayable, -13000);
object_event_add(global.yb_minimap_displayable, ev_create, 0, '
	x			= 0;
	y			= 0;
	bubbleIndex	= -1;
	size		= -1;
	color		= c_white;
	colorRate	= c_white; // the color to be displayed when rate = 1
	rate		= 1; // the opacity of the object displayed with color colorRate
');

// The minimap itself
global.yb_minimap_object = object_add();
object_set_depth(global.yb_minimap_object, -13000);
object_event_add(PlayerControl, ev_step, ev_step_end, '
	if(not instance_exists(global.yb_minimap_object)) {
		instance_create(0,0,global.yb_minimap_object);
	}
');