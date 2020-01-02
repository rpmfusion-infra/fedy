#!/bin/bash

# Instructions adopted from
# https://brave-browser.readthedocs.io/en/latest/installing-brave.html#linux

if [ -f /etc/yum.repos.d/s3-us-west-2.amazonaws.com_brave-rpm-release_x86_64.repo ] ; then
	rm -f /etc/yum.repos.d/s3-us-west-2.amazonaws.com_brave-rpm-release_x86_64.repo
fi

if [ -f /etc/yum.repos.d/brave-browser-rpm-release.s3.brave.com_x86_64_.repo ] ; then
        rm -f /etc/yum.repos.d/brave-browser-rpm-release.s3.brave.com_x86_64_.repo
fi

dnf -y remove brave brave-browser
