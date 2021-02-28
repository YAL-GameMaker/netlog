# netlog

This simple extension provides an external debug message log server for GameMaker Studio and GameMaker Studio 2 games.

**Such a thing can be useful for:**

* Seeing the debug messages when not running the game from IDE (e.g. when testing multiple instances of multiplayer games).
* Have multiple game instances send messages to the same log (also good for debugging multiplayer).
* Constantly logging data without worrying about overflowing the output log.
* Logging data on platforms with broken logging (e.g. OSX).
* Logging over network.
* Having persistent log between game launches.

**Setting up:**

* Add the extension to your project (right click on extension - Add Existing - pick the .gmez file).
* Add the included files from extension to your project.  
	These are marked to not be included in any builds by default.
* Somewhere on game start, add **netlog_init("<server ip>", <server port>);**.   
	e.g. to connect to the same computer on default port you would do **netlog_init("127.0.0.1", 5101);**. Omitting this will display **netlog(_)** messages via **show_debug_message(_)** instead.
* Add a "Async - Networking" event to any persistent controller object and add **netlog_async_net();** there.
* When you need to display debug information, use **netlog("<message>");**. If you already have a custom debug log function, may very well add the call to there.
* If using GMS2 macOS, install [Neko VM](http://nekovm.org/) runtime (Windows version uses .NET runtime).

**Running:**

* GMS1: Double-click "netlog.exe" in Included Files to start up the program.
* GMS2 Windows: Right-click "netlog.exe" in Included Files and pick "Edit".
* GMS2 macOS: Right-click "netlog.n" in Included Files, pick "Open in Explorer/Finder (Ctrl+Shift+O)". Open terminal in that directory and do "neko netlog.n".

Have fun!
