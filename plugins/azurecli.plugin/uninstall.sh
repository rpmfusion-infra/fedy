#!/bin/bash

if command rpm --query --quiet azure-cli; then
    dnf -y remove azure-cli
    rm -f /etc/yum.repos.d/azurecli.repo
fi
