#!/bin/bash

URL=$(wget "https://vivaldi.com/download/" -O - | tr ' ' '\n' | grep -o "http*.\?://.*vivaldi.*.$(uname -m).rpm" | head -n 1)
dnf -y install "$URL"
