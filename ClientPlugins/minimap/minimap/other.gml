object_event_add(global.yb_minimap_object, ev_create, 0, '
	underHealingHudTimer = 0;
');

object_event_add(global.yb_minimap_object, ev_step, ev_step_begin, '
	var doubleCheck;
	doubleCheck = false;
	if(instance_exists(HealingHud)) {
		if(HealingHud.target != noone) {
			underHealingHudTimer = min(1, underHealingHudTimer + 0.2);
			doubleCheck = true;
		}
	}
	if(not doubleCheck) {
		underHealingHudTimer = max(0, underHealingHudTimer - 0.2);
	}
');

object_event_add(global.yb_minimap_object, ev_keypress, 0, '
	if(not instance_exists(InGameMenuController)) {
		if (keyboard_check_pressed(global.yb_minimap_zoomKey) || keyboard_check_released(global.yb_minimap_zoomKey)) {
			global.yb_minimap_zooming = !global.yb_minimap_zooming;
		}
	}
');