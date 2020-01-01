#!/bin/bash

dnf config-manager -y --add-repo https://download.opensuse.org/repositories/network:messaging:xmpp:dino/Fedora_$releasever/network:messaging:xmpp:dino.repo
dnf install dino -y
