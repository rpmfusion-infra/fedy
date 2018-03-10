#!/bin/bash

dnf config-manager --add-repo https://download.opensuse.org/repositories/network:messaging:xmpp:dino/Fedora_27/network:messaging:xmpp:dino.repo
dnf install dino
