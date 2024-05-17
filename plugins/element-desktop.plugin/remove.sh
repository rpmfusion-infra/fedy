#!/bin/bash

if [ -f '/etc/yum.repos.d/home:jejb1:Element.repo' ] ; then
  rm '/etc/yum.repos.d/home:jejb1:Element.repo'
fi

dnf remove -y element-desktop

# OBS used to extend gpg usage, but dnf/dnf5 cannot cope with it
# Remove the gpg-key so the extended key can be re-imported later
# This key is an old DSA/1024
rpm -e gpg-pubkey-53325d7e-61f8c878 &>/dev/null
