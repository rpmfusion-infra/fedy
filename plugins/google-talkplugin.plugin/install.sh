#!/bin/bash

rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
dnf -y install https://dl.google.com/linux/direct/google-talkplugin_current_$(uname -i).rpm

