#!/bin/bash

if command rpm --query --quiet code; then
    dnf -y remove code
    rm -f /etc/yum.repos.d/vscode.repo
fi
