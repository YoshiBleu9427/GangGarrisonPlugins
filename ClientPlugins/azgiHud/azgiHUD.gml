// This plugin changes global HUDs
// made by YB

globalvar azgiHUD;
azgiHUD = id;

// plugin properties
barWidth = 7;
barHeight = 60;
barGap = 6;
iconGap = 6;

barXOffset = 10;
barYOffset = 10;

opacity = 0.8;

uberBlink = true;


// load icons
var path;
path = directory + "\azgiHUD\img\";

healthIcon = sprite_add(path + "healthIcon.png", 1,1,0,0,0);
ammoIcon = sprite_add(path + "ammoIcon.png", 1,1,0,0,0);
uberIcon = sprite_add(path + "uberIcon.png", 1,1,0,0,0);
nutsIcon = sprite_add(path + "nutsIcon.png", 1,1,0,0,0);
sandwichIcon = sprite_add(path + "sandwichIcon.png", 1,1,0,0,0);
mineIcon = sprite_add(path + "mineIcon.png", 1,1,0,0,0);
sentryIcon = sprite_add(path + "sentryIcon.png", 1,1,0,0,0);
sniperIcon = sprite_add(path + "sniperIcon.png", 1,1,0,0,0);
flareIcon = sprite_add(path + "flareIcon.png", 1,1,0,0,0);


// define macros: drawIcon, drawBar

// args in: icon, usedColor, xoffset, yoffset
drawIconStr = '
	// draw icon
	if(icon != -1) {
		draw_sprite_ext(
			icon,
			0,
			xoffset + azgiHUD.barWidth / 2 - sprite_get_width(icon) / 2,
			yoffset - azgiHUD.barHeight - azgiHUD.iconGap - sprite_get_height(icon) / 2,
			1,
			1,
			0,
			usedColor,
			azgiHUD.opacity
		);
	}
';

// args in: usedColor, ratio, xoffset, yoffset
drawBarStr = '
	// draw bar
	draw_set_color(c_black);
	draw_set_alpha(0.4 * azgiHUD.opacity);
	draw_rectangle(xoffset, yoffset, xoffset + azgiHUD.barWidth, yoffset - azgiHUD.barHeight, false);
	draw_set_color(usedColor);
	draw_set_alpha(azgiHUD.opacity);
	draw_rectangle(xoffset, yoffset, xoffset + azgiHUD.barWidth, yoffset - (azgiHUD.barHeight * ratio), false);
	draw_set_color(c_white);
';


// load scripts
path = directory + "\azgiHUD\scripts\";

execute_file(path + "HealthHud.gml");
execute_file(path + "SentryHealthHud.gml");
execute_file(path + "AmmoHud.gml");
execute_file(path + "Flares.gml");
execute_file(path + "HealedHud.gml");
execute_file(path + "HealingHud.gml");
execute_file(path + "Uber.gml");
execute_file(path + "Bolts.gml");
execute_file(path + "Sandwich.gml");
execute_file(path + "Stickies.gml");