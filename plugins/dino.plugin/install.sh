#!/bin/bash

source /etc/os-release

dnf config-manager --add-repo https://download.opensuse.org/repositories/network:messaging:xmpp:dino/Fedora_$VERSION_ID/network:messaging:xmpp:dino.repo
dnf install dino
