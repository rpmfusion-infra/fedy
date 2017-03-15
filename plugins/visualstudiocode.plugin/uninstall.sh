#!/bin/bash

if command rpm --query --quiet code; then
    dnf -y --setopt clean_requirements_on_remove=1 erase code
    rm -f /etc/yum.repos.d/vscode.repo
fi

if command rpm --query --quiet vscode; then
    dnf -y --setopt clean_requirements_on_remove=1 erase vscode
    rm -f /etc/yum.repos.d/_copr_mosquite-vscode.repo
fi
