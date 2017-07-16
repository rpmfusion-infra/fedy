#!/bin/bash

dnf -y remove syncthing syncthing-gtk
dnf copr -y disable decathorpe/syncthing
