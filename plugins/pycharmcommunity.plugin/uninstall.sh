#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 erase pycharm-community
dnf copr -y disable phracek/PyCharm
