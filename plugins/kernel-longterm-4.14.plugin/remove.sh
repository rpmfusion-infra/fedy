#!/bin/bash

if [[ $(uname -r) =~ ^4.1[49] ]] ; then
  echo "Running kernel-longterm refusing to remove"
  exit 1
fi

dnf copr disable kwizart/kernel-longterm-4.14 -y
dnf remove -y kernel-longterm\*
