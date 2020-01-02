#!/bin/bash

# Instructions adopted from
# https://brave-browser.readthedocs.io/en/latest/installing-brave.html#linux

# old brave version
if [ -f /etc/yum.repos.d/s3-us-west-2.amazonaws.com_brave-rpm-release_x86_64.repo ] ; then
	rm -f s3-us-west-2.amazonaws.com_brave-rpm-release_x86_64.repo
fi

rpm -q --quiet brave && dnf -y remove brave

# new brave-browser version

dnf config-manager -y --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

dnf -y install brave-browser
