# Name: SSD I/O Scheduler
# Command: disk_io_scheduler
# Value: True
SCHEDULER=noop
FLAG=false
UDEV_RULE_FILE=/etc/udev/rules.d/60-io_schedulers.rules

disk_io_scheduler() {
	show_func "Starting SSD I/O Scheduler plugin"
	for DISK in `\ls -d /sys/block/sd*` ; do
		ROT=$DISK/queue/rotational
		SCHED=$DISK/queue/scheduler
		if [[ `cat $ROT` -eq 0 ]] ; then
			if [[ -w $SCHED ]] ; then
				show_msg "Found SSD disk: $DISK; set scheduler to $SCHEDULER"
				echo $SCHEDULER > $SCHED
				FLAG=true
			fi
		fi
	done
	if [[ $FLAG -eq true ]]; then
		install_udev_rule_file $UDEV_RULE_FILE
	fi
	exit_state
}

install_udev_rule_file() {
	if [[ ! -f $1 ]]; then
		create_udev_rule_file $1
		show_status "udev rules for io schedulers installed at $1"
  else
    show_msg "udev rules for io schedulers appears to be already installed; check $1 to verify"
	fi
}

create_udev_rule_file() {
	# based on: https://wiki.archlinux.org/index.php/Solid_State_Drives
	echo '# set deadline scheduler for non-rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="noop"
# set cfq scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="cfq"' > $1
}

disk_io_scheduler_test() {
if [[ -f $UDEV_RULE_FILE ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}

