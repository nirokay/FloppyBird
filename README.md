# __FlöppyBird__

FlöppyBird is yet another open-source Flappy Bird clone (please don't sue me) written in Lua, using the Löve2d Game Engine.

---

## __1. Changelog (v0.6)__

+ updated builder (added .AppImage format)
+ coin counter dynamic updates
+ custom skin support (read readme in love directory about usage)

---

## __2. Roadmap__

(🔜 planned features, ❓ unsure)

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

The final build will be located in `/.build/builds/`. The build script builds a native Windows Executable, AppImage and a .love file, which can be run with the Löve2d Game Engine.

### 3.3 Installing Löve2d Game Engine

Love2d comes with Lua built into it, you dont have to download Lua 5.4 seperatly.

+ Arch Linux: `sudo pacman -S love`
+ Debian/Ubuntu: `sudo snap install love`
+ Windows and other systems: [Love2d Download](https://love2d.org)

---
