// SANDWICH
//
object_event_clear(SandwichHud, ev_draw, 0);
object_event_add(SandwichHud, ev_draw, 0, '
		
	if (global.myself.object == -1 || global.myself.class != CLASS_HEAVY) exit;

	//
	var xoffset, yoffset;
	xoffset = view_xview[0] + azgiHUD.barXOffset + (azgiHUD.barWidth + azgiHUD.barGap) * 2;
	yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;

	// ratio	
	var ratio;
	ratio = (1-(global.myself.object.alarm[6]/(global.myself.object.eatCooldown / global.delta_factor)))
	
	var icon, usedColor;
	icon = azgiHUD.sandwichIcon;
	if(ratio >= 1) {
		usedColor = c_white;
	} else {
		usedColor = c_gray;
	}
	
	' + drawIconStr + '
	' + drawBarStr + '
');
