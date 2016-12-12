#!/bin/bash

dnf -y config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo
dnf -y install libdvdcss
