#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 erase arc-theme
rm -f /etc/yum.repos.d/home:Horst3180.repo
