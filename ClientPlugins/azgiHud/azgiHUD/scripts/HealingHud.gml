// Unused: HealingHUD
//
/*object_event_clear(HealingHud, ev_draw, 0);
object_event_add(HealingHud, ev_draw, 0, '
	if (instance_exists(target))
	{
		var healthRate;
		
		healthRate = target.object.hp/target.object.maxHp;
	}
');*/
