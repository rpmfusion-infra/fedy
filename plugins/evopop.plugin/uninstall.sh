#!/bin/bash

dnf copr -y disable phnxrbrn/evopop
dnf -y --setopt clean_requirements_on_remove=1 erase evopop-icon-theme evopop-gtk-theme
