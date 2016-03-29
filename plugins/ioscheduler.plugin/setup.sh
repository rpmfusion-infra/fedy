#!/bin/bash

# This script originally had NOOP as the default scheduler for SSDs, but now deadline is used instead.
# The scheduler variable has replaced by two separate variables, one each for SSDs and HDDs.
# This will make it easier to switch back to NOOP or any other scheduler for both types of hard disks in the future.

# References
# IO scheduler udev rules: https://wiki.archlinux.org/index.php/Solid_State_Drives
# Deadline on SSDs: https://wiki.debian.org/SSDOptimization#Low-Latency_IO-Scheduler

ssd_scheduler="deadline"
hdd_scheduler="deadline"

cat <<EOF | tee "/etc/udev/rules.d/60-io_schedulers.rules" > /dev/null 2>&1
# Set deadline scheduler for non-rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="$ssd_scheduler"
# Set deadline scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="$hdd_scheduler"
EOF

for disk in /sys/block/sd*; do
    rot="$disk/queue/rotational"
    sched="$disk/queue/scheduler"

    if [[ $(cat "$rot") -eq 0 ]]; then
        echo "$ssd_scheduler | tee $sched > /dev/null 2>&1"
    elif [[ $(cat "$rot") -eq 1 ]]; then
        echo "$hdd_scheduler | tee $sched > /dev/null 2>&1"
    fi
done
