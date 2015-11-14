#!/bin/bash

sudo rm -f /var/tmp/smartgit-generic-*.tar.gz*
sudo rm -f /var/tmp/changelog.txt*
wget -P /var/tmp/ https://www.syntevo.com/smartgit/changelog.txt

LATEST=$(head -n 1 /var/tmp/changelog.txt)
VERSION=$(echo "$LATEST" | grep -Po '(?<=SmartGit )\d.\d.\d' | tr "." _)

wget -P /var/tmp http://www.syntevo.com/downloads/smartgit/smartgit-generic-$VERSION.tar.gz

tar xfzv /var/tmp/smartgit*.tar.gz -C /opt

ln -fs /opt/smartgit/bin/smartgit.sh /usr/local/bin/smartgit
/opt/smartgit/bin/add-menuitem.sh

