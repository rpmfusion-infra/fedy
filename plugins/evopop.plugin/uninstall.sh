#!/bin/bash

dnf copr -y disable tcg/themes
dnf -y --setopt clean_requirements_on_remove=1 remove EvoPop-theme EvoPop-Azure-theme
