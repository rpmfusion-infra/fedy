#!/bin/bash

# https://www.filebot.net/forums/viewtopic.php?t=10631

cat > /etc/yum.repos.d/Filebot-Fedora.repo << "EOF" 
[filebot]
name=filebot
baseurl=https://get.filebot.net/rpm/main/x86_64
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub
enabled=1
enabled_metadata=1
EOF


dnf -y install zenity mediainfo filebot