#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 erase HandBrake-gui
rm -f /etc/yum.repos.d/fedora-handbrake.repo
