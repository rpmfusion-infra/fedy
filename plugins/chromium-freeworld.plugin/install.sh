#!/bin/bash


# Disable legacy chromium-libs-media-freeworld
rpm --query --quiet chromium-libs-media-freeworld
has_legacy_chromium=$?

if [ ${has_legacy_chromium} ] ; then
  dnf swap chromium-libs-media-freeworld chromium-libs-media -y --quiet
fi

# Install current chromium-freeworld
# (It will replace chromium-vaapi if needed)
dnf install chromium-freeworld -y
