// FLARES FOR PYRO
//
object_event_add(AmmoCounter, ev_draw, 0, '

    if (global.myself.object == -1 || global.myself.class != CLASS_PYRO) exit;
	if !instance_exists(global.myself.object.currentWeapon) exit;
	
	var currWeap, nbFlares;
	currWeap = global.myself.object.currentWeapon;
	
	nbFlares = floor(currWeap.ammoCount/75);

	// position offset
	var xoffset, yoffset;
	xoffset = view_xview[0] + azgiHUD.barXOffset + (azgiHUD.barWidth + azgiHUD.barGap) * 2;
	yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;

	// color
	var usedColor;
	if(currWeap.readyToFlare) {
		usedColor = c_white;
	} else {
		usedColor = c_gray;
	}

	var icon;
	icon = azgiHUD.flareIcon;
	draw_set_alpha(azgiHUD.opacity);
	draw_set_color(usedColor);
	if(icon != -1) {
		var i;
		for(i = 0; i < nbFlares; i+=1) {
			draw_sprite_ext(
				icon,
				0,
				xoffset + azgiHUD.barWidth / 2 - sprite_get_width(icon) / 2,
				yoffset - azgiHUD.iconGap - sprite_get_height(icon) / 2,
				1,
				1,
				0,
				usedColor,
				azgiHUD.opacity
			);
			yoffset -= azgiHUD.iconGap + sprite_get_height(icon);
		}
	} else {
		draw_text(xoffset, yoffset, string(nbFlares)); // lol
	}
	draw_set_color(c_white);
');
