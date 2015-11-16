#!/bin/bash

dnf config-manager --add-repo=http://negativo17.org/repos/fedora-handbrake.repo
dnf -y install HandBrake-gui
