#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 remove syncthing syncthing-gtk
dnf copr -y disable decathorpe/syncthing
