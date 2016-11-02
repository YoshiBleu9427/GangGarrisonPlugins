// Unused: HealedHUD
//
/*object_event_clear(HealedHud, ev_draw, 0);
object_event_add(HealedHud, ev_draw, 0, '

	if(healed) {

		var healthRate, uberRate;
		var uberColor;
		
		// medic bubble is 45, uber is 46
		healthRate = healerhp / 120;
		uberRate = healerUberCharge / 2000;
			
		if(global.myself.object.ubered) {
			uberColor = c_green;
		} else {
			uberColor = c_black;
		}
	}
');*/
