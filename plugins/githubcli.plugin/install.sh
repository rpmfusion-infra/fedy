#!/bin/bash

dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

dnf -y install gh
