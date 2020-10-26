#!/bin/bash

if [ -f /etc/yum.repos.d/packages.microsoft.com_yumrepos_ms-teams_.repo ] ; then
  rm -f /etc/yum.repos.d/packages.microsoft.com_yumrepos_ms-teams_.repo
fi

dnf remove -y teams
