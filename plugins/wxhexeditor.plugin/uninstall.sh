#!/bin/bash

dnf copr -y disable brollylssj/wxHexEditor
dnf -y --setopt clean_requirements_on_remove=1 remove wxHexEditor
