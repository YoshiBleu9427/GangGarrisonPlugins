// create menu objects

// MAIN PLUGIN MENU
//
//
if !variable_global_exists("pluginOptions") {
    global.pluginOptions = object_add();
    object_set_parent(global.pluginOptions,OptionsController);  
    object_set_depth(global.pluginOptions,-130000); 
    object_event_add(global.pluginOptions,ev_create,0,'   
    menu_create(40, 140, 300, 200, 30);

    if room != Options {
        menu_setdimmed();
    }

    menu_addback("Back", "
        instance_destroy();
        if(room == Options)
            instance_create(0,0,MainMenuController);
        else
            instance_create(0,0,InGameMenuController);
    ");
    ');
    
    object_event_add(InGameMenuController,ev_create,0,'
        menu_addlink("Plugin Options", "
            instance_destroy();
            instance_create(0,0,global.pluginOptions);
        ");
    ');
} 

object_event_add(global.pluginOptions, ev_create, 0, '
	menu_addlink("Minimap plugin options", "
		instance_destroy();
		instance_create(0,0,global.yb_minimap_menu);
	");
');





// MINIMAP MENU
//
//
global.yb_minimap_menu = object_add();
object_set_parent(global.yb_minimap_menu,OptionsController);  
object_set_depth(global.yb_minimap_menu,-130000); 
object_event_add(global.yb_minimap_menu,ev_create,0,'   
	menu_create(40, 140, 300, 200, 30);

	if room != Options {
		menu_setdimmed();
	}
	menu_addback("Back", "
		instance_destroy();
		instance_create(0,0,global.pluginOptions);
	");

');

object_event_add(global.yb_minimap_menu,ev_keypress,vk_escape,'   
	instance_destroy();
	instance_create(0,0,global.pluginOptions);
');

object_event_add(global.yb_minimap_menu, ev_create, 0, '
    section = "Plugins";
    key_yb_minimap_show 			= "yb_minimap_show";
    key_yb_minimap_posx				= "yb_minimap_posx";
    key_yb_minimap_posy				= "yb_minimap_posy";
    key_yb_minimap_posw				= "yb_minimap_posw";
    key_yb_minimap_posh				= "yb_minimap_posh";
    key_yb_minimap_posx_medic		= "yb_minimap_posx_medic";
    key_yb_minimap_posy_medic		= "yb_minimap_posy_medic";
    key_yb_minimap_posw_medic		= "yb_minimap_posw_medic";
    key_yb_minimap_posh_medic		= "yb_minimap_posh_medic";
    key_yb_minimap_method			= "yb_minimap_method";
	key_yb_minimap_fit				= "yb_minimap_fit";
    key_yb_minimap_zoomKey			= "yb_minimap_zoomKey";
	key_yb_minimap_zoomRange		= "yb_minimap_zoomRange";
	key_yb_minimap_nearHealingHud	= "yb_minimap_nearHealingHud";
	key_yb_minimap_alpha			= "yb_minimap_alpha";
	
    menu_addedit_boolean("Minimap: Enable:", "global.yb_minimap_show", "
        gg2_write_ini(section, key_yb_minimap_show, argument0);
	");
    menu_addlink("Select minimap position and size", "
		instance_destroy();
		instance_create(0,0,global.yb_minimap_posmenu);
	");
    menu_addlink("Select displayed objects", "
		instance_destroy();
		instance_create(0,0,global.yb_minimap_whomenu);
	");
    menu_addlink("Color and size options", "
		instance_destroy();
		instance_create(0,0,global.yb_minimap_colormenu);
	");
    menu_addedit_select("Show method", "global.yb_minimap_method", "
        gg2_write_ini(section, key_yb_minimap_method, argument0);
	");
	menu_add_option(global.yb_minimap_method_dots, "Little dots");
	menu_add_option(global.yb_minimap_method_bigdots, "Big dots");
	menu_add_option(global.yb_minimap_method_bubble, "Class bubbles");
    menu_addedit_select("Fit method", "global.yb_minimap_fit", "
        gg2_write_ini(section, key_yb_minimap_fit, argument0);
	");
	menu_add_option(global.yb_minimap_fit_auto, "Auto fit, no scroll");
	menu_add_option(global.yb_minimap_fit_width, "Horizontal fit, vertical scroll");
	menu_add_option(global.yb_minimap_fit_height, "Vertical fit, horizontal scroll");
	menu_add_option(global.yb_minimap_fit_reverse, "Auto fit, auto scroll");
	menu_addedit_key("Zoom toggle key:", "global.yb_minimap_zoomKey", "
        gg2_write_ini(section, key_yb_minimap_zoomKey, argument0);
	");
	// Slider for zoom range
	menu_addlink("Zoom range:","");
	zoomSlider = instance_create(40 + 200, 140 + 7 * 30, yb_slider.Slider);
	with(zoomSlider) { 
		minValue = 0.2;
		maxValue = 5;
		width = 300;
		boundVar = "global.yb_minimap_zoomRange"
		onChange = "gg2_write_ini(section, key_yb_minimap_zoomRange, argument0);"
		
		// heh
		section = "Plugins";
		key_yb_minimap_zoomRange = "yb_minimap_zoomRange";
	}
    menu_addedit_boolean("Move to Healing HUD", "global.yb_minimap_nearHealingHud", "
        gg2_write_ini(section, key_yb_minimap_nearHealingHud, argument0);
	");
	// Slider for opacity
	menu_addlink("Opacity:","");
	opacitySlider = instance_create(40 + 200, 140 + 9 * 30, yb_slider.Slider);
	with(opacitySlider) { 
		minValue = 0;
		maxValue = 100;
		width = 300;
		boundVar = "global.yb_minimap_alpha"
		onChange = "gg2_write_ini(section, key_yb_minimap_alpha, argument0);"
		
		// heh
		section = "Plugins";
		key_yb_minimap_alpha = "yb_minimap_alpha";
	}
');
object_event_add(global.yb_minimap_menu, ev_destroy, 0, '
	with(zoomSlider) {
		instance_destroy();
	}
	with(opacitySlider) {
		instance_destroy();
	}
');




// SETTINGS - WHO menu (what has to be displayed)
//
//
global.yb_minimap_whomenu = object_add();
object_set_parent(global.yb_minimap_whomenu,OptionsController);  
object_set_depth(global.yb_minimap_whomenu,-130000); 
object_event_add(global.yb_minimap_whomenu,ev_create,0,'   
	menu_create(40, 140, 300, 200, 30);

	if room != Options {
		menu_setdimmed();
	}
	menu_addback("Back", "
		instance_destroy();
		instance_create(0,0,global.yb_minimap_menu);
	");

');

object_event_add(global.yb_minimap_whomenu,ev_keypress,vk_escape,'   
	instance_destroy();
	instance_create(0,0,global.yb_minimap_menu);
');

object_event_add(global.yb_minimap_whomenu, ev_create, 0, '
    section = "Plugins";
    key_yb_minimap_who				= "yb_minimap_who";
    key_yb_minimap_showHealth 		= "yb_minimap_showHealth";
	key_yb_minimap_showObjective	= "yb_minimap_showObjective";
	key_yb_minimap_showSentry		= "yb_minimap_showSentry";
    menu_addedit_select("Players shown:", "global.yb_minimap_who", "
        gg2_write_ini(section, key_yb_minimap_who, argument0);
	");
	menu_add_option(global.yb_minimap_who_noone, "No one");
	menu_add_option(global.yb_minimap_who_myself, "Myself only");
	menu_add_option(global.yb_minimap_who_allies, "Allies");
    menu_addedit_boolean("Show health:", "global.yb_minimap_showHealth", "
        gg2_write_ini(section, key_yb_minimap_showHealth, argument0);
	");
    menu_addedit_boolean("Show objective:", "global.yb_minimap_showObjective", "
        gg2_write_ini(section, key_yb_minimap_showObjective, argument0);
	");
    menu_addedit_boolean("Show sentries:", "global.yb_minimap_showSentry", "
        gg2_write_ini(section, key_yb_minimap_showSentry, argument0);
	");
');





// SETTINGS - COLOR and SIZE menu
//
//
global.yb_minimap_colormenu = object_add();
object_set_parent(global.yb_minimap_colormenu,OptionsController);  
object_set_depth(global.yb_minimap_colormenu,-130000); 
object_event_add(global.yb_minimap_colormenu,ev_create,0,'   
	menu_create(40, 140, 300, 200, 30);

	if room != Options {
		menu_setdimmed();
	}
	menu_addback("Back", "
		instance_destroy();
		instance_create(0,0,global.yb_minimap_menu);
	");

');

object_event_add(global.yb_minimap_colormenu,ev_keypress,vk_escape,'   
	instance_destroy();
	instance_create(0,0,global.yb_minimap_menu);
');

object_event_add(global.yb_minimap_colormenu, ev_create, 0, '
    section = "Plugins";
	key_yb_minimap_bubbleSize 		= "yb_minimap_bubbleSize";
	key_yb_minimap_bubbleSelfSize 	= "yb_minimap_bubbleSelfSize";
	key_yb_minimap_bubbleSelfColor 	= "yb_minimap_bubbleSelfColor";
	key_yb_minimap_bubbleObj		= "yb_minimap_bubbleObj";
	
    menu_addedit_num("Bubbles size:", "global.yb_minimap_bubbleSize", "
        gg2_write_ini(section, key_yb_minimap_bubbleSize, argument0);
	", 200);
    menu_addedit_num("My bubbles size:", "global.yb_minimap_bubbleSelfSize", "
        gg2_write_ini(section, key_yb_minimap_bubbleSelfSize, argument0);
	", 200);
    menu_addedit_select("My color:", "global.yb_minimap_bubbleSelfColor", "
        gg2_write_ini(section, key_yb_minimap_bubbleSelfColor, argument0);
	");
	menu_add_option(c_red, "Red");
	menu_add_option(c_yellow, "Yellow");
	menu_add_option(c_green, "Green");
	menu_add_option(c_blue, "Blue");
	menu_add_option(c_white, "White (none)");
    menu_addedit_num("Obj. bubble size:", "global.yb_minimap_bubbleObj", "
        gg2_write_ini(section, key_yb_minimap_bubbleObj, argument0);
	", 200);
');





// SETTINGS - MAP POSITION menu
//
//
global.yb_minimap_posmenu = object_add();
object_set_parent(global.yb_minimap_posmenu,OptionsController);  
object_set_depth(global.yb_minimap_posmenu,-130000); 

object_event_add(global.yb_minimap_posmenu,ev_create,0,'
	oldx = global.yb_minimap_posx;
	oldy = global.yb_minimap_posy;
	oldw = global.yb_minimap_posw;
	oldh = global.yb_minimap_posh;
	oldx_medic = global.yb_minimap_posx_medic;
	oldy_medic = global.yb_minimap_posy_medic;
	oldw_medic = global.yb_minimap_posw_medic;
	oldh_medic = global.yb_minimap_posh_medic;
	nbClicks = 0;
');

object_event_add(global.yb_minimap_posmenu,ev_destroy,0,'
    gg2_write_ini("Plugins", "yb_minimap_posx", global.yb_minimap_posx);
    gg2_write_ini("Plugins", "yb_minimap_posy", global.yb_minimap_posy);
    gg2_write_ini("Plugins", "yb_minimap_posw", global.yb_minimap_posw);
    gg2_write_ini("Plugins", "yb_minimap_posh", global.yb_minimap_posh);
');
object_event_add(global.yb_minimap_posmenu,ev_step,0,'
	switch(nbClicks) {
		case 0:
			global.yb_minimap_posx	= mouse_x - view_xview[0];
			global.yb_minimap_posy	= mouse_y - view_yview[0];
			break;
		case 1:
			global.yb_minimap_posw	= max(20, mouse_x - global.yb_minimap_posx - view_xview[0]);
			global.yb_minimap_posh	= max(20, mouse_y - global.yb_minimap_posy - view_yview[0]);
			break;
		case 2:
			global.yb_minimap_posx_medic	= mouse_x - view_xview[0];
			global.yb_minimap_posy_medic	= mouse_y - view_yview[0];
			break;
		case 3:
			global.yb_minimap_posw_medic	= max(20, mouse_x - global.yb_minimap_posx - view_xview[0]);
			global.yb_minimap_posh_medic	= max(20, mouse_y - global.yb_minimap_posy - view_yview[0]);
			break;
		default:
			instance_destroy();
			instance_create(0,0,global.yb_minimap_menu);
	}
');
object_event_add(global.yb_minimap_posmenu,ev_draw,0,'
	var xoffset, yoffset, msg;
	var mapx, mapy, mapw, maph;
	xoffset = view_xview[0];
	yoffset = view_yview[0];
	switch(nbClicks) {
		case 0:
			msg = "Click to set the minimaps position. Press ESC to cancel.";
			break;
		case 1:
			msg = "Click to set the minimaps size. Press ESC to cancel.";
			break;
		case 2:
			msg = "Click to set the minimaps position when healing. Press ESC to cancel.";
			break;
		case 3:
			msg = "Click to set the minimaps size when healing. Press ESC to cancel.";
			break;
		default:
	}
	mapx = global.yb_minimap_posx + xoffset;
	mapy = global.yb_minimap_posy + yoffset;
	mapw = global.yb_minimap_posw;
	maph = global.yb_minimap_posh;
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	draw_text(mouse_x - 8, mouse_y - 8, msg);
	draw_set_color(c_black);
	draw_text(mouse_x + 16, mouse_y + 16, msg);
	draw_set_alpha(0.5);
	draw_rectangle(mapx, mapy, mapx + mapw, mapy + maph, false);
	draw_set_color(c_black);
	draw_rectangle(mapx, mapy, mapx + mapw, mapy + maph, true);
	draw_set_alpha(1);
');
object_event_add(global.yb_minimap_posmenu,ev_keypress,vk_escape,'   
	nbClicks -= 1;
	if(nbClicks == 3) {
		global.yb_minimap_posw_medic	= oldw_medic;
		global.yb_minimap_posh_medic	= oldh_medic;
	} else if(nbClicks == 2) {
		global.yb_minimap_posw_medic	= oldx_medic;
		global.yb_minimap_posh_medic	= oldy_medic;
	} else if(nbClicks == 1) {
		global.yb_minimap_posw	= oldw;
		global.yb_minimap_posh	= oldh;
	} else {
		global.yb_minimap_posx	= oldx;
		global.yb_minimap_posy	= oldy;
		instance_destroy();
		instance_create(0,0,global.yb_minimap_menu);
	}
');
object_event_add(global.yb_minimap_posmenu,ev_mouse,ev_global_left_press,'   
	nbClicks += 1;
');