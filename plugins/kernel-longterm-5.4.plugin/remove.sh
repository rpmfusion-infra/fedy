#!/bin/bash

if [[ $(uname -r) =~ ^5.4 ]] ; then
  echo "Running kernel-longterm refusing to remove"
  exit 1
fi

dnf copr disable kwizart/kernel-longterm-5.4 -y
dnf remove -y kernel-longterm\*
