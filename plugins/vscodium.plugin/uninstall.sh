#!/bin/bash

if command rpm --query --quiet codium; then
    dnf -y remove codium
    rm -f /etc/yum.repos.d/vscodium.repo
fi
