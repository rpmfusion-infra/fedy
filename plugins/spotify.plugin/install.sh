#!/bin/bash

dnf config-manager --set-disabled --repo=fedora-spotify -y &>/dev/null || :

dnf -y install lpf-spotify-client
