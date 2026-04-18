#!/bin/bash

if [ -f /etc/yum.repos.d/cursor.repo ]; then
  rm -f /etc/yum.repos.d/cursor.repo
fi

dnf -y remove cursor
