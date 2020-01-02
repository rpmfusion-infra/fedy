#!/bin/bash

dnf remove -y b43-openfwwf
dnf install -y rpmfusion-nonfree-release-tainted
dnf install -y b43-firmware b43-tools
