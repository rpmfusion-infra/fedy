#!/bin/bash


rpm -q --quiet libva-intel-media-driver
libva_intel_media_driver_test=$?

if [ $libva_intel_media_driver_test == 0 ] ; then
  dnf remove -y libva-intel-media-driver
fi

dnf install -y intel-media-driver
