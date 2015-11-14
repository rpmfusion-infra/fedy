#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

LATEST=$(head -n 1 /var/tmp/changelog.txt)
VERSION=$(echo "$LATEST" | grep -Po '(?<=SmartGit )\d.\d.\d' | tr "." _)

wget -P /var/tmp http://www.syntevo.com/downloads/smartgit/smartgit-generic-$VERSION.tar.gz

tar xfzv /var/tmp/smartgit*.tar.gz -C /opt

ln -fs /opt/smartgit/bin/smartgit.sh /usr/local/bin/smartgit
/opt/smartgit/bin/add-menuitem.sh

