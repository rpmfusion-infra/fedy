#!/bin/bash

# Dino is now in fedora

if [ -f /etc/yum.repos.d/network:messaging:xmpp:dino.repo ] ; then
  rm /etc/yum.repos.d/network:messaging:xmpp:dino.repo
fi

dnf install dino -y
