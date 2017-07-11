#!/bin/bash

dnf -y install steam

# Make "Big picture" mode work
setsebool -P allow_execheap 1
