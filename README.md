A repository of plugins for Gang Garrison 2, made by me

# How it works

A GG2 plugin is a .gml file, that is executed on startup by the game. Every .gml file in the `Plugins` folder will be executed, but not the subfolders.

As a general rule of thumb, it is considered good pratice to have one main gml file named after the name of your plugin, and a subfolder containing most of the actual code and all the resources of the plugin.
Obviously, for very short scripts (<80 lines), you might as well just write it all in your main file.

# How to browse

The repo is split into three categories:
 - client-side plugins (`ClientPlugins`)
 - server-side plugins (`ServerPlugins`)
 - **server-sent** plugins (`ServerSentPlugins`)
 
Client plugins are plugins that will work both for the client and the server, like graphic or control overhauls.

Server plugins are utilities that only work the server host; like a plugin to force the current round to end, or to kill everybody instantly.

Server-sent plugins are game-changing modifications that need to be synced between the client and the server, like changing gravity, alternate weapons, etc.

---

In this repo, each plugin has its own subfolder, containing
 - a README;
 - the main gml file;
 - when necessary, a subfolder with the other script files, and/or the required resources;
 - sometimes screenshots.
 
# How to use

Each plugin is in its own, separate folder, which means you can just download that folder, and copy it into your own Plugins folder.

For instance, if you want to use the minimap plugin, you should copy `ClientPlugins/Minimap` into your Plugins folder, and you should end up with the following structure:

```
Plugins/
 |_ minimap/
 |  \_(a bunch of gml files)
 \_ minimap.gml
```