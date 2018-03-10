#!/bin/bash

dnf copr -y disable heikoada/gtk-themes
dnf -y remove adapta-gtk-theme-common adapta-gtk-theme-gtk2 adapta-gtk-theme-gtk3 adapta-gtk-theme-gtk4
