#!/bin/bash

dnf copr -y disable  mosquito/vscode
dnf -y --setopt clean_requirements_on_remove=1 erase  vscode -y
