#!/bin/bash
echo -e "\e[1;33m Building source .love \e[0m"
build="_with_build"
zip -9 -r "$1$build".love . -x ./.build/builds/**\* ./.git/**\* ./.TODO.txt ./.gitignore
mv "$1$build".love ./.build/builds

echo -e "\e[1;33m Building .love \e[0m"
zip -9 -r "$1".love . -x ./.build/**\* ./.git/**\* ./.TODO.txt ./.gitignore
mv "$1".love ./.build/builds