#!/bin/bash

gdm_status=1

if [ -f /etc/gdm/custom.conf ] ; then
    gdm_status=$(grep -E -c "^WaylandEnable=false" /etc/gdm/custom.conf)
fi

exit $gdm_status
