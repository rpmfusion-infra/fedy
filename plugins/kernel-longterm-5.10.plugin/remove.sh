#!/bin/bash

if [[ $(uname -r) =~ ^5.10 ]] ; then
  echo "Running kernel-longterm refusing to remove"
  exit 1
fi

dnf copr disable kwizart/kernel-longterm-5.10 -y
dnf remove -y kernel-longterm\*
