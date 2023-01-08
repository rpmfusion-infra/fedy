#!/bin/bash

rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge

dnf install microsoft-edge-stable -y
