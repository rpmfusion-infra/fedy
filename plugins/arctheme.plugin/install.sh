#!/bin/bash

dnf -y copr enable mhdahmad/workstation
sudo dnf -y install arc-theme --repo copr:copr.fedorainfracloud.org:mhdahmad:workstation #remove package redundancy

