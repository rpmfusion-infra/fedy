#!/bin/bash

dnf -y remove android-udev-rules

if [ -f "/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:nielsenb:android-udev-rules.repo" ]; then
	rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:nielsenb:android-udev-rules.repo
fi
