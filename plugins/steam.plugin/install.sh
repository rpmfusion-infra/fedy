#!/bin/bash

dnf config-manager --add-repo=http://negativo17.org/repos/fedora-steam.repo

dnf -y install steam

# Make "Big picture" mode work
setsebool -P allow_execheap 1
