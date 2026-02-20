#!/bin/bash

if [ -f /etc/yum.repos.d/microsoft-edge-stable.repo ] ; then
  rm -f /etc/yum.repos.d/microsoft-edge-stable.repo
fi

if [ -f /etc/yum.repos.d/microsoft-edge-dev.repo ] ; then
  rm -f /etc/yum.repos.d/microsoft-edge-dev.repo
fi

if [ -f /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo ] ; then
  rm -f /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo
fi


dnf remove microsoft-edge-stable -y
