#!/bin/bash

if command rpm --query --quiet teams; then
    dnf -y remove teams
    rm -f /etc/yum.repos.d/teams.repo
fi
