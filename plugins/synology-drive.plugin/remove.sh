#!/bin/bash

if [ -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:emixampp:synology-drive.repo ] ; then
        rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:emixampp:synology-drive.repo
fi

dnf -y remove synology-drive
