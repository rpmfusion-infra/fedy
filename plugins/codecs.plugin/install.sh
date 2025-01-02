#!/usr/bin/bash

if [ -f /etc/os-release ] ; then
 . /etc/os-release
fi

rpm -q --quiet ffmpeg-free
ffmpeg_free_test=$?

rpm -q --quiet libavcodec-free
libavcodec_free_test=$?

# groupupdate multimedia doesn't work well until fedora-40 with libavcodec-freeworld

if [ ${ID} == "fedora" -a "${VERSION_ID}" -ge 40 ]; then
  dnf -y install libavcodec-freeworld
elif [ ${ID} != "fedora" -a "${VERSION_ID}" -ge 9 ]; then
  dnf -y install libavcodec-freeworld
elif [ ${ID} != "fedora" -a "${VERSION_ID}" -lt 9 ]; then
  dnf -y install ffmpeg
elif [ x$ffmpeg_free_test == x0 ] ; then
  dnf -y swap ffmpeg-free ffmpeg --allowerasing
elif [ x$libavcodec_free_test == x0 ] ; then
  dnf -y swap libavcodec-free ffmpeg-libs --allowerasing
else
  dnf -y install ffmpeg
fi

dnf -y install @multimedia --exclude=PackageKit-gstreamer-plugin,libva-intel-media-driver
