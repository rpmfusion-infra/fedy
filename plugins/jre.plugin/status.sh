#!/bin/bash

if [[ $(rpm --query --all jre1.8*) ]]; then
    exit 0
else
    exit 1
fi
