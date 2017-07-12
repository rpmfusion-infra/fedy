#!/bin/bash

dnf copr -y disable brollylssj/PeaZip
dnf -y --setopt clean_requirements_on_remove=1 remove peazip
