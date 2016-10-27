# Minimap

[Forum thread here](http://www.ganggarrison.com/forums/index.php?topic=33732.0)

This plugin draws a minimap in the corner of your screen.

The minimap shows the map background, and also displays the position of the rest of your team, and your objectives (Intelligences, Capture Points, Generators).

# Dependencies

Uses Slider [TODO link to Slider plugin]

For the plugin to work properly, you will need to download and install all the dependencies listed above.


# How it works

The plugin is split into six files.

 - `menus.gml` initialises the menus
 - `vars.gml` initialises global variables, and variables from ini files
 - `objects.gml` defines the objects
 - `other.gml` listens for events (key press, onHealing) to move the map around
 - `collecting.gml` defines the minimap step event, to collect the list of entitites that need to be displayed
 - `drawing.gml` defines the minimap draw event, to display the minimap and the entities to display
 
The main file first executes the Slider dependency, then executes the files listed above.

# TODO

 - Add option: show only on pause screen
 - Use absolute zoom instead of relative (currently is relative to map size) 
 - Fix display for maps using scale != default (6) (i.e. cp_scrap)
 - Add option: when moving minimap from default to healing pos, let the user customize the move duration (10 frames as it is)