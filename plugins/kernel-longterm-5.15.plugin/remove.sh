#!/bin/bash

if [[ $(uname -r) =~ ^5.15 ]] ; then
  echo "Running kernel-longterm refusing to remove"
  exit 1
fi

dnf copr disable kwizart/kernel-longterm-5.15 -y
dnf remove -y "kernel-longterm-*-5.15.*-200.*
