#!/bin/bash

URL="http://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.$(uname -m).rpm"

dnf install -y $URL
