#!/bin/bash

for i in va vdpau ; do
  _package=0
  rpm -q --quiet mesa-${i}-drivers
  _package=$?
  if [ ${_package} == 0 ] ; then
    dnf swap mesa-${i}-drivers mesa-${i}-drivers-freeworld -y
  else
    dnf install mesa-${i}-drivers-freeworld -y
  fi
done

