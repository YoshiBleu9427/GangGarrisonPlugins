// STICKIES
//
object_event_clear(StickyCounter, ev_draw, 0);
object_event_add(StickyCounter, ev_draw, 0, '
		
	if (global.myself.object == -1 || global.myself.class != CLASS_DEMOMAN) exit;

	// 
	var xoffset, yoffset;
	xoffset = view_xview[0] + azgiHUD.barXOffset + (azgiHUD.barWidth + azgiHUD.barGap) * 2;
	yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;

	// ratio	
	var ratio;
	ratio = global.myself.object.currentWeapon.lobbed / 8;
	
	var icon, usedColor;
	icon = azgiHUD.mineIcon;
	if(ratio >= 1) {
		usedColor = c_red;
	} else if(ratio > 0) {
		usedColor = c_white;
	} else {
		usedColor = c_gray;
	}
	
	' + drawIconStr + '
	' + drawBarStr + '
');
