#!/bin/bash

dnf config-manager --add-repo https://download.opensuse.org/repositories/home:snwh:moka/Fedora_25/home:snwh:moka.repo
dnf -y install moka-icon-theme
