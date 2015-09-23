#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 erase steam

rm -f /etc/yum.repos.d/fedora-steam.repo
