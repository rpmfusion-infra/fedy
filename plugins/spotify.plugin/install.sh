#!/bin/bash

dnf config-manager --set-disabled --repo=fedora-spotify -y &>/dev/null || :

# See also https://github.com/rpmfusion/lpf-spotify-client/pull/17#issuecomment-1864322263
dnf copr enable -y sergiomb/libayatana-appindicator

dnf -y install lpf-spotify-client
