#!/bin/bash

ret=1

if [ -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:kwizart:nvidia-driver-rawhide.repo ] ; then
	ret=0
elif [ -f /etc/yum.repos.d/ ] ; then
	ret=0
fi

exit ${ret}
