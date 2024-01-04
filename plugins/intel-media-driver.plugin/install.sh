#!/bin/bash


rpm -q --quiet libva-intel-media-driver
libva_intel_media_driver_test=$?

if [ $libva_intel_media_driver_test == 0 ] ; then
  dnf swap -y libva-intel-media-driver intel-media-driver
else
  dnf install -y intel-media-driver
fi

