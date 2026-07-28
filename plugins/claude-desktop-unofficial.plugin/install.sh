#!/bin/bash

curl -fsSL https://pkg.claude-desktop-debian.dev/rpm/claude-desktop-unofficial.repo -o /etc/yum.repos.d/claude-desktop-unofficial.repo
dnf install -y claude-desktop-unofficial
