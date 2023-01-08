#!/bin/bash

if [ -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:luminoso:Signal-Desktop.repo ] ; then
	rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:luminoso:Signal-Desktop.repo
fi

if [ -f  "/etc/yum.repos.d/network:im:signal.repo" ] ; then
	rm "/etc/yum.repos.d/network:im:signal.repo"
fi

dnf remove -y signal-desktop
