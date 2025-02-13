#!/bin/bash

if [[ $(uname -r) =~ ^6.12 ]] ; then
  echo "Running kernel-longterm refusing to remove"
  exit 1
fi

dnf copr disable kwizart/kernel-longterm-6.12 -y
dnf remove -y "kernel-longterm-*-6.12.*
