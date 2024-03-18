#!/bin/bash

dnf -y erase pycharm-community
dnf copr -y disable phracek/PyCharm

# Disable older pubkey so newer reinstall works
rpm -e gpg-pubkey-ff7d24c0-54d3b977
