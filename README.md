# FlöppyBird
FlöppyBird is yet another open-source Flappy Bird clone (please don't sue me) written in Lua, using the Löve2d Game Engine.



## _Changelog:_ (v0.4.1)

+ space bar after death to quick restart
+ mouse controls (jump with mouse)
+ fix build bug (build files now included)
+ config controls fix
+ coin gain *(future use: in-game skins etc)*
+ speed increase with pipe pass



## _Roadmap:_

(✅ added features, 🔜 planned features, ❓ unsure)

* 🔜 Unlockable Skins for your bird
* 🔜 Background and Foreground objects (clouds, grass, small rocks, etc.)
* ❓ Special Abilities



## _Installation:_


### Full Releases:

For built versions; please see the Release Tab. You can chose between:

* `*.love` **[Crossplatform]** – this is a Löve2d file, launchable if you have the Löve2d Game Engine installed (see: *Installing Löve2d Game Engine*)
* `*-win.zip` **[Windows Native]** – this is a package for Windows Operating Systems (can be run on Linux, using Windows Emulators like Wine)


### Building from Source

Building from source is easy! Execute the following command:

`./build.sh BUILD_NAME` 

The final build will be located in `/.build/builds/`. The build script builds a native Windows Executable and a .love file, which can be run with the Löve2d Game Engine.


### Installing Löve2d Game Engine:

Love2d comes with Lua built into it, you dont have to download Lua 5.4 seperatly.

* Arch Linux: `sudo pacman -S love`
* Debian/Ubuntu: `sudo snap install love`
* Windows and other systems: [Love2d Download](https://love2d.org)

