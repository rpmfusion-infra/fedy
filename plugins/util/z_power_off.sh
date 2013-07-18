# Name: Power off system when done
# Command: power_off

power_off() {
clean_temp
show_warn "The system will be powered off in 10 seconds. Press any key to cancel shutdown."
if read -n1 -t10 any_key; then
	show_msg "Shutdown cancelled"
	complete_program
else
	show_msg "Shutting down system"
	shutdown -h now
fi
exit 0
}
