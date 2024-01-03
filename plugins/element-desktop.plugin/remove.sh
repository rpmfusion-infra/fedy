#!/bin/bash

if [ -f '/etc/yum.repos.d/home:jejb1:Element.repo' ] ; then
  rm '/etc/yum.repos.d/home:jejb1:Element.repo'
fi

dnf remove -y element-desktop
