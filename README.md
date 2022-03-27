# __FlöppyBird__

FlöppyBird is yet another open-source Flappy Bird clone (please don't sue me) written in Lua, using the Löve2d Game Engine.

---

## __1. Changelog (v0.4.1)__

+ space bar after death to quick restart
+ mouse controls (jump with mouse)
+ fix build bug (build files now included)
+ config controls fix
+ coin gain _(future use: in-game skins etc)_
+ speed increase with pipe pass

---

## __2. Roadmap__

(🔜 planned features, ❓ unsure)

+ 🔜 Unlockable Skins for your bird
+ 🔜 Background and Foreground objects (clouds, grass, small rocks, etc.)
+ ❓ Special Abilities

---

## __3. Installation__

### 3.1 Full Releases

For built versions; please see the Release Tab. You can chose between:

+ `*.love` __[Crossplatform]__ – this is a Löve2d file, launchable if you have the Löve2d Game Engine installed (see: _Installing Löve2d Game Engine_)
+ `*-win.zip` __[Windows Native]__ – this is a package for Windows Operating Systems (can be run on Linux, using Windows Emulators like Wine)

### 3.2 Building from Source

Building from source is easy! Execute the following command:

`./build.sh BUILD_NAME`

The final build will be located in `/.build/builds/`. The build script builds a native Windows Executable and a .love file, which can be run with the Löve2d Game Engine.

### 3.3 Installing Löve2d Game Engine

Love2d comes with Lua built into it, you dont have to download Lua 5.4 seperatly.

+ Arch Linux: `sudo pacman -S love`
+ Debian/Ubuntu: `sudo snap install love`
+ Windows and other systems: [Love2d Download](https://love2d.org)

---
