#!/bin/bash

dnf copr -y enable decathorpe/syncthing
dnf -y install syncthing syncthing-gtk

systemctl --user --global disable --now syncthing.service
