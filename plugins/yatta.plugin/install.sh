#!/bin/bash

# installing java just to ensure it is available 
dnf -y install java-*-openjdk-devel

# Switching to cache directory

CACHEDIR="/var/cache/fedy/yatta";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"


if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="64"
else
	ARCH="32"
fi

wget -c http://marketplace.yatta.de/update/profiles/yatta-eclipse-launcher-linux-$ARCH.jar -O yatta-eclipse-launcher.jar
chmod a+x yatta-eclipse-launcher.jar
cp yatta-eclipse-launcher.jar /opt/yatta-eclipse-launcher.jar
