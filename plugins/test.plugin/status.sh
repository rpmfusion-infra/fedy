#!/bin/bash

if [[ -f /tmp/ozon-somefile.txt ]]; then
	exit 0
else
	exit 1
fi
