#!/usr/bin/bash
#

if [[ ! -f "/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:kwizart:kernel-longterm-6.12.repo" ]] ; then
	exit 1
fi
