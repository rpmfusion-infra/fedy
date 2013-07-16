# Run: complete_program

complete_program() {
clean_temp
if [[ ! "$errors" = "0" ]]; then
	if [[ $(whoami) = "root" && "$enablelog" = "yes" && -f "$logfile" ]]; then
		error_msg="Please report bugs at http://github.com/satya164/fedorautils/issues along with the logfile $logfile."
	else
		error_msg="You might want to run $program again with logging enabled and report if there are any bugs."
	fi
	show_error "$program encountered $errors error(s). $error_msg"
	[[ "$interactive" = "no" ]] || zenity --error --title="$errors error(s) occured" --text="$error_msg"
	exit 1
else
	exit 0
fi	
}
