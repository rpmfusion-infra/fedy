#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 erase syncthing syncthing-gtk
dnf copr -y disable decathorpe/syncthing
