// This plugin allows you to change the server's welcome message, and also enables you to send messages to all players.
// This may be useful to alert players when you're going to shutdown. Vanilla compatible.
// Made by YB


//make a new menu for plugin options
if !variable_global_exists("pluginOptions") {
    global.pluginOptions = object_add();
    object_set_parent(global.pluginOptions,OptionsController);  
    object_set_depth(global.pluginOptions,-130000); 
    object_event_add(global.pluginOptions,ev_create,0,'   
    menu_create(40, 140, 300, 200, 30);

    if room != Options {
        menu_setdimmed();
    }

    menu_addback("Back", "
        instance_destroy();
        if(room == Options)
            instance_create(0,0,MainMenuController);
        else
            instance_create(0,0,InGameMenuController);
    ");
    ');
    
    object_event_add(InGameMenuController,ev_create,0,'
        menu_addlink("Plugin Options", "
            instance_destroy();
            instance_create(0,0,global.pluginOptions);
        ");
    ');
} 


// create yb_serverMessage_menu object
global.yb_serverMessage_menu = object_add();
object_set_parent(global.yb_serverMessage_menu,OptionsController);  
object_set_depth(global.yb_serverMessage_menu,-130000); 
object_event_add(global.yb_serverMessage_menu,ev_create,0,'   
	menu_create(40, 140, 300, 200, 30);

	if room != Options {
		menu_setdimmed();
	}
	menu_addback("Back", "
		instance_destroy();
		instance_create(0,0,global.pluginOptions);
	");

');
object_event_add(global.yb_serverMessage_menu,ev_keypress,vk_escape,'   
	instance_destroy();
	instance_create(0,0,global.pluginOptions);
');
	
	
	// vars
	
global.yb_serverMessage_broadcastMessage = '';
global.yb_serverMessage_personnalMessage = '';
global.yb_serverMessage_personnalMessage_to = 0;

	// menu script
	

object_event_add(global.pluginOptions, ev_create, 0, '
	if(global.isHost) {
		menu_addlink("Server message services", "
			instance_destroy();
			instance_create(0,0,global.yb_serverMessage_menu);
		");
	}
');

object_event_add(global.yb_serverMessage_menu, ev_create, 0, '
	if(global.isHost) {
		menu_addedit_text2("Server name:", "global.serverName", "
			var newMessage;
			newMessage = string_copy(argument0, 0, 25);
			return newMessage;
		");
		menu_addedit_text2("Welcome message:", "global.welcomeMessage", "
			var newMessage;
			newMessage = string_copy(argument0, 0, 255);
			return newMessage;
		");
		menu_addedit_text2("Password:", "global.serverPassword", "
			var newPasswd;
			newPasswd = string_copy(argument0, 0, 255);
			return newPasswd;
		");
		menu_addedit_num("Player limit:", "global.playerLimit", "", 1337);
		menu_addedit_text2("Welcome message:", "global.welcomeMessage", "
			var newMessage;
			newMessage = string_copy(argument0, 0, 255);
			return newMessage;
		");
		menu_addedit_text2("Broadcast message:", "global.yb_serverMessage_broadcastMessage", "
			var newMessage;
			newMessage = string_copy(argument0, 0, 255);
			return newMessage;
		");
		menu_addlink("Send broadcast message", global.yb_serverMessage_sendBroadcastMessageScript);
		menu_addedit_text2("Personnal message:", "global.yb_serverMessage_personnalMessage", "
			var newMessage;
			newMessage = string_copy(argument0, 0, 255);
			return newMessage;
		");
		menu_addedit_select("PM to:", "global.yb_serverMessage_personnalMessage_to", "");
		var i;
		for(i = 0; i < ds_list_size(global.players); i+=1) {
			var playerName;
			playerName = ds_list_find_value(global.players, i).name;
			menu_add_option(i, playerName);
		}
		menu_addlink("Send personnal message", global.yb_serverMessage_personnalMessageScript);
	}
');

	// real script
	
	
global.yb_serverMessage_sendBroadcastMessageScript = '
	if(global.yb_serverMessage_broadcastMessage != "") {
		ServerMessageString(global.yb_serverMessage_broadcastMessage,global.sendBuffer);
		with NoticeO instance_destroy();
		notice = instance_create(0, 0, NoticeO);
		notice.notice = NOTICE_CUSTOM;
		notice.message = global.yb_serverMessage_broadcastMessage;
	}
';

global.yb_serverMessage_personnalMessageScript = '
	if(global.yb_serverMessage_personnalMessage != "") {
		var player;
		player = ds_list_find_value(global.players, global.yb_serverMessage_personnalMessage_to);
		if player == 0 {
			with NoticeO instance_destroy();
			notice = instance_create(0, 0, NoticeO);
			notice.notice = NOTICE_CUSTOM;
			notice.message = "Error sending message: the selected player is no longer connected.";
		} else {
			ServerMessageString(global.yb_serverMessage_personnalMessage, player.socket);
			with NoticeO instance_destroy();
			notice = instance_create(0, 0, NoticeO);
			notice.notice = NOTICE_CUSTOM;
			notice.message = "To " + player.name + ": " + global.yb_serverMessage_personnalMessage;
		}
	}
';

