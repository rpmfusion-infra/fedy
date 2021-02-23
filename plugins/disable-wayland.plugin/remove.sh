#!/bin/bash

if [ -f /etc/gdm/custom.conf ] ; then
	sed -i -e 's|^WaylandEnable.*|#WaylandEnable=false|' /etc/gdm/custom.conf
fi
