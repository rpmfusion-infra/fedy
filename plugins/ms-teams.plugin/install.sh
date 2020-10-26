#!/bin/bash


# Add Microsoft teams official repository
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/ms-teams/
dnf install -y teams
