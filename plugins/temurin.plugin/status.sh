#!/bin/bash

if [ -f /etc/yum.repos.d/adoptium.repo ]; then
    exit 0
else
    exit 1
fi
