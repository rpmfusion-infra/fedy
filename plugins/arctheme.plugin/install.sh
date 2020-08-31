#!/bin/bash

dnf -y copr disable user501254/Arc #Repo is no longer updated and may be installed for Arc Icons. Diabled to prevent regression into unmaintained fork.
dnf -y copr enable mhdahmad/workstation
sudo dnf -y install arc-theme --repo copr:copr.fedorainfracloud.org:mhdahmad:workstation #Just in case

