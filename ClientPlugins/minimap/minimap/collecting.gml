object_event_add(global.yb_minimap_object, ev_step, ev_step_end, '

	if(not global.yb_minimap_show) return 0;
	if(global.myself.object == -1) return 0;

	var mahTeam;
	var bubbleIndex, size, color1, color2, rate;
	
	// DRAWING CHARACTERS
	var i;
	for(i = ds_list_size(global.yb_minimap_displayables) - 1; i >= 0; i-=1) {
		with(ds_list_find_value(global.yb_minimap_displayables, i)) {
			instance_destroy();
		}
	}
	ds_list_clear(global.yb_minimap_displayables);
	
	// If you only want the minimap you can stop right now
	if(global.yb_minimap_who == global.yb_minimap_who_noone) return 0;
	
	// If you only want yourself to be shown
	if(global.yb_minimap_who == global.yb_minimap_who_myself) {
		with(global.myself.object) {
			var newObject;
			var subImgIndex, classIndex;
			classIndex = global.myself.class;
			if(global.myself.team == TEAM_BLUE) classIndex += 10;
			subImgIndex = global.yb_minimap_bubble[classIndex];
			newObject = instance_create(0,0,global.yb_minimap_displayable);
			newObject.x = x;
			newObject.y = y;
			newObject.bubbleIndex = subImgIndex;
			newObject.size = global.yb_minimap_bubbleSelfSize / 100;
			newObject.color = global.yb_minimap_bubbleSelfColor;
			if(global.yb_minimap_showHealth) newObject.colorRate = c_red;
			newObject.rate = 1 - (hp / maxHp);
			ds_list_add(global.yb_minimap_displayables, newObject);
			newObject = noone;
		}
		if(global.yb_minimap_showSentry && global.myself.sentry != noone) {
			with(global.myself.sentry) {
				var newObject;
				newObject = instance_create(0,0,global.yb_minimap_displayable);
				newObject.x = x;
				newObject.y = y;
				newObject.bubbleIndex = 31;
				newObject.size = global.yb_minimap_bubbleSelfSize / 100;
				newObject.color = global.yb_minimap_bubbleSelfColor;
				if(global.yb_minimap_showHealth) newObject.colorRate = c_red;
				newObject.rate = 1 - (hp / 100);
				ds_list_add(global.yb_minimap_displayables, newObject);
				newObject = noone;
			}
		}
		
	// If you want to draw all of the characters in your team
	} else {		
		mahTeam = global.myself.team;
		with(Character) {
			if(team == mahTeam) {
				var newObject;
				var subImgIndex, classIndex;
				newObject = instance_create(0,0,global.yb_minimap_displayable);
				newObject.x = x;
				newObject.y = y;
				classIndex = player.class;
				if(team == TEAM_BLUE) classIndex += 10;
				newObject.bubbleIndex = global.yb_minimap_bubble[classIndex];;
				if(player == global.myself) {
					newObject.size = global.yb_minimap_bubbleSelfSize / 100;
					newObject.color = global.yb_minimap_bubbleSelfColor;
				} else {
					newObject.size = global.yb_minimap_bubbleSize / 100;
					newObject.color = c_white;
				}
				if(global.yb_minimap_showHealth) newObject.colorRate = c_red;
				newObject.rate = 1 - (hp / maxHp);
				ds_list_add(global.yb_minimap_displayables, newObject);
				newObject = noone;
			}
		}
		if(global.yb_minimap_showSentry) {
			with(Sentry) {
				if(team == mahTeam) {
					var newObject;
					newObject = instance_create(0,0,global.yb_minimap_displayable);
					newObject.x = x;
					newObject.y = y;
					newObject.bubbleIndex = 31;
					if(ownerPlayer == global.myself) {
						newObject.size = global.yb_minimap_bubbleSelfSize / 100;
						newObject.color = global.yb_minimap_bubbleSelfColor;
					} else {
						newObject.size = global.yb_minimap_bubbleSize / 100;
						newObject.color = c_white;
					}
					if(global.yb_minimap_showHealth) newObject.colorRate = c_red;
					newObject.rate = 1 - (hp / 100);
					ds_list_add(global.yb_minimap_displayables, newObject);
					newObject = noone;
				}
			}
		}
	}
	
	if(global.yb_minimap_showObjective) {
		with(ControlPoint) {
			if(not locked) {
				var newObject;
				newObject = instance_create(0,0,global.yb_minimap_displayable);
				newObject.x = x;
				newObject.y = y;
				newObject.size = global.yb_minimap_bubbleObj / 100;
				if(team == global.myself.team) {
					newObject.bubbleIndex = 42;
					newObject.colorRate = c_red;
				} else {
					newObject.bubbleIndex = 41;
					newObject.colorRate = c_green;
				}
				newObject.rate = capping / capTime;
				ds_list_add(global.yb_minimap_displayables, newObject);
				newObject = noone;
			}
		}
		if(instance_exists(IntelligenceBase)) {
			var i, defPoint, atkPoint; // def: the intel to defend
			defPoint = noone;
			atkPoint = noone;
			with(IntelligenceBaseRed) {
				if(global.myself.team == TEAM_RED) {
					defPoint = id;
				} else {
					atkPoint = id;
				}
			}
			with(IntelligenceBaseBlue) {
				if(global.myself.team == TEAM_BLUE) {
					defPoint = id;
				} else {
					atkPoint = id;
				}
			}
			with(Intelligence) {
				if(team == global.myself.team) {
					defPoint = id;
				} else {
					atkPoint = id;
				}
			}
			with(Character) {
				if(intel) {
					if(id == global.myself.object) {
						if(global.myself.team == TEAM_RED) {
							atkPoint = IntelligenceBaseRed;
						} else {
							atkPoint = IntelligenceBaseBlue;
						}
					} else if(team == global.myself.team) {
						atkPoint = id;
					} else {
						defPoint = id;
					}
				}
			}
			var newObject;
			
			if(defPoint != noone) {
				newObject = instance_create(0,0,global.yb_minimap_displayable);
				newObject.size = global.yb_minimap_bubbleObj / 100;
				newObject.bubbleIndex = 42; // def
				newObject.x = defPoint.x;
				newObject.y = defPoint.y;
				ds_list_add(global.yb_minimap_displayables, newObject);
			}
			
			if(atkPoint != noone) {			
				newObject = instance_create(0,0,global.yb_minimap_displayable);
				newObject.size = global.yb_minimap_bubbleObj / 100;
				newObject.bubbleIndex = 41; // atk
				newObject.x = atkPoint.x;
				newObject.y = atkPoint.y;
				ds_list_add(global.yb_minimap_displayables, newObject);
			}
			newObject = noone;
		}
		with(Generator) {
			var newObject;
			newObject = instance_create(0,0,global.yb_minimap_displayable);
			newObject.x = x;
			newObject.y = y;
			if(team == global.myself.team) newObject.bubbleIndex = 42;
			else newObject.bubbleIndex = 41;
			newObject.size = global.yb_minimap_bubbleSize / 100;
			ds_list_add(global.yb_minimap_displayables, newObject);
			newObject = noone;
		}
	}
');