#!/bin/bash

# Instructions adopted from
# https://brave-browser.readthedocs.io/en/latest/installing-brave.html#linux

if [ -f /etc/yum.repos.d/Filebot-Fedora.repo ] ; then
	rm -f /etc/yum.repos.d/Filebot-Fedora.repo
fi

dnf -y filebot
