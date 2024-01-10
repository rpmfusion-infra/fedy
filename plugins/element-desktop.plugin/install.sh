#!/bin/bash

if [ -f /etc/os-release ]; then
 . /etc/os-release
fi

if [ x${ID} == x"fedora" ] ; then
  curl -sP /etc/yum.repos.d/ -LO https://download.opensuse.org/repositories/home:/jejb1:/Element/Fedora_${VERSION_ID}/home:jejb1:Element.repo || exit 1
  sed -i -e "s/${VERSION_ID}/\$releasever/g" '/etc/yum.repos.d/home:jejb1:Element.repo'
  sed -i -e "s/^enabled=0/enabled=1/1" '/etc/yum.repos.d/home:jejb1:Element.repo'
else
  exit 2
fi

dnf install -y element-desktop
