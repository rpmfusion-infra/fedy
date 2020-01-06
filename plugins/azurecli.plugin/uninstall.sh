#!/bin/bash

if [ -f "/etc/yum.repos.d/azurecli.repo" ]; then
  dnf -y remove azure-cli
  rm -f /etc/yum.repos.d/azurecli.repo
fi
