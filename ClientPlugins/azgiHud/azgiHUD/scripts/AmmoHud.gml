object_event_add(Weapon, ev_create, 0, '
	maxAmmo = -1;
	ammoCount = -1;
	reloadTime = -1;
');

object_event_clear(AmmoCounter, ev_draw, 0);
object_event_add(AmmoCounter, ev_draw, 0, '

	if global.myself.object != -1 {
		if instance_exists(global.myself.object.currentWeapon) {

			var currWeap, ammoRate, reloadRate;
			
			currWeap = global.myself.object.currentWeapon;
			
			// ammoRate. SPECIAL CASE FOR SNIPER 
			if(currWeap.ammoCount != -1 && currWeap.maxAmmo > 0) {
				ammoRate = currWeap.ammoCount / currWeap.maxAmmo;
			} else if(global.myself.class == CLASS_SNIPER && global.myself.object.zoomed) {
				ammoRate = currWeap.hitDamage / currWeap.maxDamage;
			} else {
				ammoRate = 0;
			}
			
			// reloadRate
			if(currWeap.reloadTime != -1) {
				reloadRate = max(0, 1 - currWeap.alarm[5] / (currWeap.reloadTime / global.delta_factor));
			} else {
				reloadRate = 1;
			}

			// position offset
			var xoffset, yoffset;
			xoffset = view_xview[0] + azgiHUD.barXOffset + (azgiHUD.barWidth + azgiHUD.barGap) * 1;
			yoffset = view_yview[0] + view_hview[0] - azgiHUD.barYOffset;

			// color
			var usedColor;
			if(global.myself.object.ubered) {
				usedColor = c_green;
			} else {
				usedColor = c_white;
			}

			// draw bar and icon
			var ratio, icon;
			ratio = ammoRate;
			icon = azgiHUD.ammoIcon;
			if(global.myself.class == CLASS_SNIPER) {
				icon = azgiHUD.sniperIcon;
			}
			' + drawIconStr + '
			' + drawBarStr + '
				
			
			// draw side bar for reloading
			if(global.myself.class != CLASS_QUOTE)
			if(reloadRate < 1) {
				draw_set_color(c_gray);
				draw_rectangle(xoffset + azgiHUD.barWidth / 2, yoffset,
					xoffset + azgiHUD.barWidth, yoffset - (azgiHUD.barHeight * reloadRate), false);
				draw_set_color(c_white);
			}
		}
	}
');
