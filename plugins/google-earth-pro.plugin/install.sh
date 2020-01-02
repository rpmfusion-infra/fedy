#!/bin/bash

rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
dnf -y install https://dl.google.com/dl/earth/client/current/google-earth-pro-stable-current.$(uname -i).rpm

