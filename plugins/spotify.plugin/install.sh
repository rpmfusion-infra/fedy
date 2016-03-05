#!/bin/bash

dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo

dnf -y install spotify-client
