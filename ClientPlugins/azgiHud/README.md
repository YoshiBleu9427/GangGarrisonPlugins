# azgiHUD

[Forum thread here](http://www.ganggarrison.com/forums/index.php?topic=36339.0)

This plugin replaces most of the health/ammo HUDs with a more minimalistic, bar-based HUD.


## How it works

The plugin has a main file, a folder for icons, and a folder for HUD-specific scripts.

The main file:
 - sets the plugin vars
 - loads the icons
 - defines two macros (for drawing icons and bars)
 - loads the other scripts
 
The scripts are loaded in the following order:
 - `HealthHud.gml`
 - `SentryHealthHud.gml`
 - `AmmoHud.gml`
 - `Flares.gml`
 - `HealedHud.gml`
 - `HealingHud.gml`
 - `Uber.gml`
 - `Bolts.gml`
 - `Sandwich.gml`
 - `Stickies.gml`


## Rewritten events

This plugin clears and rewrites the draw event for the following objects:

 - `HealthHud`
 - `SentryHealthHud`
 - `AmmoCounter`
 - `UberHud`
 - `NutsNBoltsHud`
 - `SandwichHud`
 - `StickyCounter`
 
It also initialises 3 variables in the `Weapon` create event: `maxAmmo`, `ammoCount` and `reloadTime`, all set to `-1`.


## TODO

 - Do HealedHud
 - Do HealingHud
 - Make ingame menu for editing opacity and other options