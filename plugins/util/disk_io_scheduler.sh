# Name: Set up SSD I/O scheduler
# Command: disk_io_scheduler

scheduler="noop"
ssdfound="false"
udev_rule_file="/etc/udev/rules.d/60-io_schedulers.rules"

disk_io_scheduler() {
show_func "Installing udev rules SSD I/O scheduler"
if [[ "$(disk_io_scheduler_test)" = "Configured" ]]; then
    show_status "SSD I/O scheduler already configured"
else
    for disk in `\ls -d /sys/block/sd*`; do
        rot="$disk/queue/rotational"
        sched="$disk/queue/scheduler"
        if [[ `cat $rot` -eq 0 ]]; then
            if [[ -w "$sched" ]]; then
                show_msg "Found SSD: $disk"
                echo $scheduler > $sched && show_msg "Scheduler set to $scheduler"
                ssdfound="true"
            fi
        fi
    done
    [[ "$ssdfound" = "true" ]] && install_udev_rule_file "$udev_rule_file"
fi
[[ "$(disk_io_scheduler_test)" = "Configured" ]]; exit_state
}

install_udev_rule_file() {
# Based on: https://wiki.archlinux.org/index.php/Solid_State_Drives
cat <<EOF | tee "$1" > /dev/null 2>&1
# Set noop scheduler for non-rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="$scheduler"
# Set cfq scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="cfq"
EOF
}

disk_io_scheduler_undo() {
show_func "Removing udev rules for SSD I/O scheduler"
rm -f "$udev_rule_file"
[[ ! "$(disk_io_scheduler_test)" = "Configured" ]]; exit_state
}

disk_io_scheduler_test() {
if [[ -f "$udev_rule_file" ]]; then
    printf "Configured"
else
    printf "Not configured"
fi
}

disk_io_scheduler_hide() {
for disk in `\ls -d /sys/block/sd*`; do
    rot="$disk/queue/rotational"
    sched="$disk/queue/scheduler"
    if [[ `cat $rot` -eq 0 ]]; then
        if [[ -w "$sched" ]]; then
            ssdfound="true"
        fi
    fi
done
if [[ ! "$ssdfound" = "true" ]]; then
    printf "true"
fi
}
