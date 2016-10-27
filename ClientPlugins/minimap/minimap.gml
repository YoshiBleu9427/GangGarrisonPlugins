// This plugin draws a minimap that represents the current map's background.
// Teammates, freindly sentries, and objectives (intel, control points, generator) are shown.

// Requires Slider. Make sure to have Slider installed in \Plugins\Resources\YB\Slider
// Forums thread:

// The objects to be displayed are selected in the step event,
// and are only drawn in the draw event.
// Made by YB.


// namespace
globalvar yb_minimap;
yb_minimap = id;

// import Slider
var path;
if(GAME_NAME_STRING == '"Derpduck' + chr(39) + 's Server Mod"')
{
	path = working_directory + "\DSM_Plugins\Resources\YB\slider\";
}
else
{
	path = working_directory + "\Plugins\Resources\YB\slider\";
}
execute_file(path + "Slider.gml");

if(GAME_NAME_STRING == '"Derpduck' + chr(39) + 's Server Mod"')
{
	path = working_directory + "\DSM_Plugins\minimap\";
}
else
{
	path = working_directory + "\Plugins\minimap\";
}

execute_file(path + "menus.gml");
execute_file(path + "vars.gml");
execute_file(path + "objects.gml");
execute_file(path + "other.gml");
execute_file(path + "collecting.gml");
execute_file(path + "drawing.gml");