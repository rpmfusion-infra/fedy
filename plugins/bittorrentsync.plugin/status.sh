#!/bin/bash

FILE=/usr/bin/btsync

if [ -f $FILE ]; then
    exit 0
else
    exit 1
fi
