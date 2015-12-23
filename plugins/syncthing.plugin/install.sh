#!/bin/bash

dnf copr -y enable decathorpe/syncthing
dnf -y install syncthing syncthing-gtk
