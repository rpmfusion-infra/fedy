#!/bin/bash

dnf config-manager --set-disabled --repo=fedora-spotify &>/dev/null

dnf -y install lpf-spotify-client
