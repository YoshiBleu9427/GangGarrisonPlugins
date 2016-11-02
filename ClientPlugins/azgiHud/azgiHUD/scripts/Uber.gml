// UBERCHARGE
//
object_event_clear(UberHud, ev_draw, 0);
object_event_add(UberHud, ev_draw, 0, '
    if (global.myself.object == -1 || global.myself.class != CLASS_MEDIC) exit;

	var myMedigun, chargeRate;
	
    myMedigun=-1;
    with(Medigun) {
        if(ownerPlayer == global.myself) myMedigun=id;
    }
    if(myMedigun != -1) {

		//
		var xoffset, yoffset;
		xoffset = view_xview[0] + azgiHUD.barXOffset + (azgiHUD.barWidth + azgiHUD.barGap) * 2;
		yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;

		//
		var ratio, usedColor;
		ratio = myMedigun.uberCharge / 2000;
		usedColor = c_white;
		if(myMedigun.uberReady) {
			usedColor = c_red;
			
			if (azgiHUD.uberBlink) {
				var colorLevel;
				colorLevel = (sin((current_time mod 1500) / 1500 * 6.28) + 1) / 2 * 255;
				usedColor = make_color_rgb(colorLevel, colorLevel / 4, colorLevel / 4);
			}
		}
		if(myMedigun.ubering) {
			usedColor = c_yellow;
		}

		var icon;
		icon = azgiHUD.uberIcon;
		' + drawIconStr + '
		' + drawBarStr + '
    }
');
