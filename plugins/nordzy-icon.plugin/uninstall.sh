#!/bin/bash

dnf -y remove nordzy-icon

if [ -f "/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:rubemlrm:nordzy-icon.repo" ]; then
	rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:rubemlrm:nordzy-icon.repo
fi
