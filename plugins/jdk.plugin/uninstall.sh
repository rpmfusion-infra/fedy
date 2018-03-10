#!/bin/bash

if [[ "$(uname -m)" = "x86_64" ]]; then
    ARCH="x64"
else
    ARCH="x86"
fi

PACKAGE=$(rpm --query --all jdk1.8* | head -n 1)

dnf -y erase "$PACKAGE"

alternatives --remove java /usr/java/latest/bin/java
alternatives --auto java
alternatives --remove javac /usr/java/latest/bin/javac
alternatives --auto javac

if [[ "$arch" = "x86" ]]; then
    alternatives --remove libjavaplugin.so /usr/java/latest/jre/lib/i386/libnpjp2.so
    alternatives --auto libjavaplugin.so
elif [[ "$arch" = "x64" ]]; then
    alternatives --remove libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so
    alternatives --auto libjavaplugin.so.x86_64
fi
