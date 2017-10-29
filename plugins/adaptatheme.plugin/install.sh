#!/bin/bash

dnf -y copr enable heikoada/gtk-themes
dnf -y install adapta-gtk-theme-common adapta-gtk-theme-gtk2 adapta-gtk-theme-gtk3 adapta-gtk-theme-gtk4
