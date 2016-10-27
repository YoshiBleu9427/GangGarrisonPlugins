globalvar MVPRewards;
MVPRewards = id;



// OBJECTS
//
Controller = object_add();
object_set_persistent(Controller, true);
object_event_add(Controller, ev_create, 0, '
	if(global.isHost) {
		hashList = ds_list_create();
	}
	roundHasEnded = false;
	myHash = "";
');
object_event_add(Controller, ev_destroy, 0, '
	if(global.isHost) {
		ds_list_destroy(hashList);
	}
');


Networker = object_add();
object_set_persistent(Networker, true);
object_event_add(Networker, ev_create, 0, '
	sendBuffer = buffer_create();
');
object_event_add(Networker, ev_destroy, 0, '
	buffer_destroy(sendBuffer);
');


Reward = object_add();
object_event_add(Reward, ev_create, 0, '
	owner = noone;
');


// CONSTS
//
GIVE_REWARD		= 1;
REMOVE_REWARD	= 0;
REWARD_HASH		= 2;


// MAKE IT HAPPEN
//
object_event_add(Player, ev_create, 0, '
	MVPRewards_hasReward = false;
	MVPRewards_hash = "";
');
object_event_add(Player, ev_step, ev_step_begin, '
	if(not variable_local_exists("MVPRewards_hasReward")) {
		MVPRewards_hasReward = false;
		MVPRewards_hash = "";
	}
');
object_event_add(Player, ev_destroy, 0, '
	with(MVPRewards.Reward) {
		if(owner == other.id) {
			instance_destroy();
		}
	}
	execute_string(MVPRewards.removeHash, MVPRewards_hash);
');

object_event_add(PlayerControl, ev_step, ev_step_begin, '
	if(not instance_exists(MVPRewards.Controller))
		instance_create(0,0,MVPRewards.Controller);
		
	if(not instance_exists(MVPRewards.Networker))
		instance_create(0,0,MVPRewards.Networker);
');





// SCRIPT
//
//

// REWARD CHECKING AND CREATION
object_event_add(Controller, ev_step, ev_step_end, '
	if(roundHasEnded) {
		if(global.winners == -1) {
			// MAP STARTUP
			roundHasEnded = false;
			if(global.isHost) {
				if(global.myself.MVPRewards_hasReward) {
					execute_string(MVPRewards.sendGiveReward, global.myself);
					execute_string(MVPRewards.doGiveReward, global.myself);
				}
			} else {
				if(myHash != "") {
					execute_string(MVPRewards.sendHash, myHash);
				}
			}
		}
	} else {
		if(global.winners != -1) {
			// ROUND ENDED
			roundHasEnded = true;
			if(global.isHost) {
				var mostBestest, hiScore, hash;
				hiScore = 0;
				with(Player) {
					if(team != global.winners) {
						execute_string(MVPRewards.removeHash, MVPRewards_hash);
						execute_string(MVPRewards.sendRemoveReward,id);
						execute_string(MVPRewards.doRemoveReward,id);
					}
					if(hiScore < stats[POINTS]) {
						hiScore = stats[POINTS];
						mostBestest = id;
					}
				}
				with(mostBestest) {
					hash = execute_string(MVPRewards.generateHash);
					execute_string(MVPRewards.sendHashTo,hash,id);
					execute_string(MVPRewards.sendGiveReward,id);
					execute_string(MVPRewards.doGiveReward,id);
				}
			} else {
				// uh nothing to do
			}
		}
	}
');

generateHash = '
	var str;
	str = "";
	
	random_set_seed(current_time);
	randomize();
		
	repeat(16) {
		str += chr(irandom(25) + ord("A"));
	}
	ds_list_add(MVPRewards.Controller.hashList, str);
	return str;
';

removeHash = '
	if(global.isHost)
	with(MVPRewards.Controller) {
		var index;
		index = ds_list_find_index(hashList, argument0);
		if(index > -1) {
			ds_list_delete(hashList, index);
		}
	}
';


// REWARD STUFF
//
object_event_add(Reward, ev_draw, 0, '
	if(owner.object == -1)
		exit;
	if(owner.object.invisible)
		exit;
	draw_set_alpha(owner.object.image_alpha);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	/*if(team == TEAM_RED)	draw_set_color(c_red);
	else 					draw_set_color(c_blue);*/
	draw_set_color(make_color_hsv(current_time * 360 / 1000 mod 360, 196, 196));
	draw_text(owner.object.x, owner.object.y+20, "MVP");
');

// NETWORKING
//
//
object_event_add(Networker, ev_step, ev_step_normal, '
	with(MVPRewards) {
		var sendingPlayer, readBuffer, read;
		while(PluginPacketGetBuffer(packetID) != -1) {
			readBuffer = PluginPacketGetBuffer(packetID);
			while(buffer_bytes_left(readBuffer) > 0) {
				read = read_ubyte(readBuffer);
				switch(read) {
					case GIVE_REWARD:
						if(not global.isHost) {
							sendingPlayer = ds_list_find_value(global.players, read_ubyte(readBuffer));
							execute_string(doGiveReward, sendingPlayer);
						}
						break;
					case REMOVE_REWARD:
						if(not global.isHost) {
							sendingPlayer = ds_list_find_value(global.players, read_ubyte(readBuffer));
							execute_string(doRemoveReward, sendingPlayer);
						}
						break;
					case REWARD_HASH:
						var hash;
						hash = execute_string(receiveHash, readBuffer);
						with(Controller) {
							if(global.isHost) {
								sendingPlayer = PluginPacketGetPlayer(other.packetID);
								execute_string(other.removeHash, sendingPlayer.MVPRewards_hash);
								sendingPlayer.MVPRewards_hash = hash;
								if(ds_list_find_index(hashList, hash) > -1) {
									execute_string(other.sendGiveReward, sendingPlayer);
									execute_string(other.doGiveReward, sendingPlayer);
								}
							} else {
								myHash = hash;
							}
						}
						break;
				}
			}
			PluginPacketPop(packetID);
			readBuffer = PluginPacketGetBuffer(packetID);
		}
		if(buffer_size(other.sendBuffer) > 0) {
			PluginPacketSend(packetID, other.sendBuffer);
			buffer_clear(other.sendBuffer);
		}
	}
');

sendGiveReward = '
	write_ubyte(MVPRewards.Networker.sendBuffer, MVPRewards.GIVE_REWARD);
	write_ubyte(MVPRewards.Networker.sendBuffer, ds_list_find_index(global.players, argument0));
';
doGiveReward = '
	var player;
	player = argument0;
	
	with(instance_create(0,0,MVPRewards.Reward)) {
		owner = player;
	}
	player.MVPRewards_hasReward = true;
';

sendRemoveReward = '
	write_ubyte(MVPRewards.Networker.sendBuffer, MVPRewards.REMOVE_REWARD);
	write_ubyte(MVPRewards.Networker.sendBuffer, ds_list_find_index(global.players, argument0));
';
doRemoveReward = '
	with(MVPRewards.Reward) {
		if(owner == argument0) {
			instance_destroy();
		}
	}
	argument0.MVPRewards_hasReward = false;
	if(argument0 == global.myself) {
		myHash = "";
	}
';

sendHash = '
	write_ubyte(MVPRewards.Networker.sendBuffer, MVPRewards.REWARD_HASH);
	write_string(MVPRewards.Networker.sendBuffer, argument0);
';
sendHashTo = '
	var buffer;
	buffer = buffer_create();
	write_ubyte(buffer, MVPRewards.REWARD_HASH);
	write_string(buffer, argument0);
	PluginPacketSendTo(MVPRewards.packetID, buffer, argument1);
	buffer_destroy(buffer);
';
receiveHash = '
	return read_string(argument0, 16);
';

// GIVE INFO TO NEW PLAYERS
//
object_event_add(Player, ev_create, 0, '
	if(global.isHost and id != global.myself) {
		with(Player) {
			if(MVPRewards_hasReward) {
				execute_string(MVPRewards.sendGiveReward,id);
			}
		}
	}
');