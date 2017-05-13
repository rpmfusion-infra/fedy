#!/bin/bash

dnf copr -y disable user501254/Arc
dnf -y --setopt clean_requirements_on_remove=1 erase arc-icon-theme
