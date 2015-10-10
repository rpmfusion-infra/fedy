#!/bin/bash

URL=$(wget "https://vivaldi.com/download/" -O - | grep -o "https://vivaldi.com/download/vivaldi_TP[0-9.-]*.$(uname -i).rpm" | head -n 1)
dnf -y install "$URL"
