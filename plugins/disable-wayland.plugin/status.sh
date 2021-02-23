#!/bin/bash

if [ -f /etc/gdm/custom.conf ] ; then
	local gdm_status=$(egrep -c "^WaylandEnable=false$" /etc/gdm/custom.conf)
fi

exit $gdm_status
