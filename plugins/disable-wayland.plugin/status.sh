#!/bin/bash

if [ -f /etc/gdm/custom.conf ] ; then
    gdm_status=$(egrep -c "^WaylandEnable=false" /etc/gdm/custom.conf)
fi

exit $gdm_status
