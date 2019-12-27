#!/bin/bash

dnf install dnf-plugins-core -y
dnf copr enable flatcap/neomutt -y
dnf install neomutt -y
