// vars
// ini vars
ini_open("gg2.ini");
global.yb_minimap_show			= ini_read_real("Plugins","yb_minimap_show",			true);
global.yb_minimap_showHealth	= ini_read_real("Plugins","yb_minimap_showHealth",		true);
global.yb_minimap_showObjective	= ini_read_real("Plugins","yb_minimap_showObjective",	true);
global.yb_minimap_showSentry	= ini_read_real("Plugins","yb_minimap_showSentry",		true);
global.yb_minimap_posx			= ini_read_real("Plugins","yb_minimap_posx",			0); // relative coords on the screen
global.yb_minimap_posy			= ini_read_real("Plugins","yb_minimap_posy",			0);
global.yb_minimap_posw			= ini_read_real("Plugins","yb_minimap_posw",			200); // max size of the minimap
global.yb_minimap_posh			= ini_read_real("Plugins","yb_minimap_posh",			200);
global.yb_minimap_posx_medic	= ini_read_real("Plugins","yb_minimap_posx_medic",		0); // relative coords on the screen when healing
global.yb_minimap_posy_medic	= ini_read_real("Plugins","yb_minimap_posy_medic",		0);
global.yb_minimap_posw_medic	= ini_read_real("Plugins","yb_minimap_posw_medic",		200); // max size of the minimap when healing
global.yb_minimap_posh_medic	= ini_read_real("Plugins","yb_minimap_posh_medic",		200);
global.yb_minimap_method		= ini_read_real("Plugins","yb_minimap_method",			2); // see show_method consts
global.yb_minimap_fit			= ini_read_real("Plugins","yb_minimap_fit",				0); // see fit consts
global.yb_minimap_who			= ini_read_real("Plugins","yb_minimap_who",				2); // see show_who consts
global.yb_minimap_bubbleSize 	= ini_read_real("Plugins","yb_minimap_bubbleSize",		40); // In percentage
global.yb_minimap_bubbleSelfColor = ini_read_real("Plugins","yb_minimap_bubbleSelfColor",	c_green);
global.yb_minimap_bubbleSelfSize = ini_read_real("Plugins","yb_minimap_bubbleSelfSize",	40); // In percentage
global.yb_minimap_alpha			= ini_read_real("Plugins", "yb_minimap_alpha",			100);
global.yb_minimap_bubbleObj 	= ini_read_real("Plugins","yb_minimap_bubbleObj",		80); // Bubbles for Objective (Intel, Cp, gen) In percentage
global.yb_minimap_zoomKey		= ini_read_real("Plugins","yb_minimap_zoomKey",			ord("R"));
global.yb_minimap_zoomRange		= ini_read_real("Plugins","yb_minimap_zoomRange",		2); // 0: close, 1: middle, 2: large, 3: very large
global.yb_minimap_nearHealingHud = ini_read_real("Plugins", "yb_minimap_nearHealingHud", false); // should the map be displayed somewhere else when healing
ini_close();

// zoom
global.yb_minimap_zooming = false;
global.yb_minimap_zoomRange_close = 0;
global.yb_minimap_zoomRange_middle = 1;
global.yb_minimap_zoomRange_large = 2;
global.yb_minimap_zoomRange_verylarge = 3;

// show_method consts
global.yb_minimap_method_dots = 0;
global.yb_minimap_method_bigdots = 1;
global.yb_minimap_method_bubble = 2;

// show_who consts
global.yb_minimap_who_noone = 0;
global.yb_minimap_who_myself = 1;
global.yb_minimap_who_allies = 2;

// fit consts
global.yb_minimap_fit_auto = 0;
global.yb_minimap_fit_width = 1;
global.yb_minimap_fit_height = 2;
global.yb_minimap_fit_reverse = 3;

// class bubbles: red
global.yb_minimap_bubble[CLASS_SCOUT] = 0;
global.yb_minimap_bubble[CLASS_PYRO] = 1;
global.yb_minimap_bubble[CLASS_SOLDIER] = 2;
global.yb_minimap_bubble[CLASS_HEAVY] = 3;
global.yb_minimap_bubble[CLASS_DEMOMAN] = 4;
global.yb_minimap_bubble[CLASS_MEDIC] = 5;
global.yb_minimap_bubble[CLASS_ENGINEER] = 6;
global.yb_minimap_bubble[CLASS_SPY] = 7;
global.yb_minimap_bubble[CLASS_SNIPER] = 8;
global.yb_minimap_bubble[CLASS_QUOTE] = 47;
// class bubbles: blue
global.yb_minimap_bubble[CLASS_SCOUT + 10] = 10;
global.yb_minimap_bubble[CLASS_PYRO + 10] = 11;
global.yb_minimap_bubble[CLASS_SOLDIER + 10] = 12;
global.yb_minimap_bubble[CLASS_HEAVY + 10] = 13;
global.yb_minimap_bubble[CLASS_DEMOMAN + 10] = 14;
global.yb_minimap_bubble[CLASS_MEDIC + 10] = 15;
global.yb_minimap_bubble[CLASS_ENGINEER + 10] = 16;
global.yb_minimap_bubble[CLASS_SPY + 10] = 17;
global.yb_minimap_bubble[CLASS_SNIPER + 10] = 18;
global.yb_minimap_bubble[CLASS_QUOTE + 10] = 48;