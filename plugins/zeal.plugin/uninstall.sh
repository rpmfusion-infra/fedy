#!/bin/bash

dnf copr -y disable rohan62442/zeal
dnf -y --setopt clean_requirements_on_remove=1 erase zeal
