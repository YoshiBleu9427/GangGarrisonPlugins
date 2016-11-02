object_event_clear(SentryHealthHud, ev_draw, 0);
object_event_add(SentryHealthHud, ev_draw, 0, '

	if(global.myself.sentry == noone) {
		instance_destroy();
		exit;
	}

	//
	var xoffset, yoffset;
	xoffset = view_xview[0] + azgiHUD.barXOffset + (azgiHUD.barWidth + azgiHUD.barGap) * 3;
	yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;
	
	//
	var ratio, usedColor;
	ratio = global.myself.sentry.hp / 100;
	usedColor = c_white;
	if(ratio < 0.4) {
		usedColor = c_red;
	}
	
	var icon;
	icon = azgiHUD.sentryIcon;
	' + drawIconStr + '
	' + drawBarStr + '
');
