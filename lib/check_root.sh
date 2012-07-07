check_root() {
show_func "Verifying root access"
if [ ! $(whoami) = "root" ]; then
	show_error "Root access is needed to run $program"
	zenity --question --title="Root access needed!" -- text="$program needs root access to work. Are you sure to continue?" --ok-label "Yes" --cancel-label "No"
	if [ $? = "1" ]; then
		terminate_program
	else
		add_sudoer
		show_warn "Attempting to run $program with root previleges!"
		exec sudo $0 "$@"
		exit;
	fi
else
	show_status "$user registered as logged in User"
fi
}
