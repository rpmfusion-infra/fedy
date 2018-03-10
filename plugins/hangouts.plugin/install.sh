#!/bin/bash

## Download and importing Google key needed for Google Hangouts
rpm --import https://dl.google.com/linux/linux_signing_key.pub

dnf -y install https://dl.google.com/linux/direct/google-talkplugin_current_$(uname -i).rpm
