# Run: check_root

check_root() {
show_func "Verifying root access"
if [[ ! $(whoami) = "root" ]]; then
	show_err "Root access is needed to run $program!"
	[[ "$interactive" = "no" ]] && terminate_program
	zenity --question --title="Root access needed!" -- text="$program needs root access to work. Are you sure to continue?" --ok-label "Yes" --cancel-label "No"
	if [[ $? -eq 0 ]]; then
		check_sudoer
		show_warn "Attempting to run $program with root previleges!"
		exec sudo "$0" "$@"
	else
		terminate_program
	fi
else
	show_status "$user registered as logged in User"
fi
}
