#!/bin/bash

dnf copr -y disable mosquito/atom
dnf -y --setopt clean_requirements_on_remove=1 erase atom -y
