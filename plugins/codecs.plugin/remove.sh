#!/bin/bash

if [ -f /etc/os-release ] ; then
 . /etc/os-release
fi

rpm -q --quiet ffmpeg-libs
ffmpeg_libs_test=$?

rpm -q --quiet libavcodec-freeworld
libavcodec_freeworld_test=$?

if [ x$ffmpeg_libs_test == x0 ] ; then
  if [ ${ID} == "fedora" ]; then
    dnf -y swap ffmpeg-libs libavcodec-free --allowerasing
  elif [ ${ID} != "fedora" -a "${VERSION_ID}" -ge 9 ] ; then
    dnf -y swap ffmpeg-libs libavcodec-free --allowerasing
  fi
elif [ x$ffmpeg_freeworld_test == x0 ] ; then
  dnf -y swap libavcodec-freeworld libavcodec-free --allowerasing
fi
