object_event_clear(HealthHud, ev_draw, 0);
object_event_add(HealthHud, ev_draw, 0, '

	if(global.myself.object == -1) {
		instance_destroy();
		exit;
	}

	var xoffset, yoffset;
	xoffset = view_xview[0] + azgiHUD.barXOffset;
	yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;
	
	var ratio, usedColor;
	ratio = global.myself.object.hp / global.myself.object.maxHp;
	usedColor = c_white;
	if(ratio < 0.3) {
		usedColor = c_red;
	}
	
	var icon;
	icon = azgiHUD.healthIcon;
	' + drawIconStr + '
	' + drawBarStr + '
');