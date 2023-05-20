#!/bin/bash

if [ -f "/etc/yum.repos.d/tonfotos.repo" ]; then
  rm -f /etc/yum.repos.d/tonfotos.repo
fi


dnf -y remove tonfotos
