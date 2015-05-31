#!/bin/bash

dnf copr -y disable satya164/brackets
dnf -y --setopt clean_requirements_on_remove=1 erase brackets
