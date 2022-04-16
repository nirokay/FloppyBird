#!/bin/bash
dir="./.build/"

echo -e "\e[1;33m Building .AppImage! \e[0m"

$dir/love/love.AppImage --appimage-extract
cat "squashfs-root/bin/love" $dir"builds/$1.love" > "squashfs-root/bin/$1.AppImage"

mv "squashfs-root/bin/$1.AppImage" $dir"builds/"

rm -rf "squashfs-root"

echo -e "\e[1;33m Built .AppImage! \e[0m"