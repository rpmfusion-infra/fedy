#!/bin/bash

FILE=/usr/local/bin/btsync

if [ -f $FILE ]; then
    exit 0
else
    exit 1
fi
