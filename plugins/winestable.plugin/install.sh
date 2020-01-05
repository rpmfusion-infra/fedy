#!/bin/bash

dnf config-manager -y --add-repo https://dl.winehq.org/wine-builds/fedora/31/winehq.repo

dnf -y install winehq-stable
