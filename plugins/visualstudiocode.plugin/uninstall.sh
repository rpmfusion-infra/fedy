#!/bin/bash

if command rpm --query --quiet code; then
    dnf -y --setopt clean_requirements_on_remove=1 remove code
    rm -f /etc/yum.repos.d/vscode.repo
fi
