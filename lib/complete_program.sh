complete_program() {
if [[ ! "$errors" = "0" ]]; then
	if [[ $(whoami) = "root" && "$enablelog" = "yes" && -f "$logfile" ]]; then
		show_error "$program encountered $errors errors. Please report bugs at http://github.com/satya164/fedorautils/issues along with the logfile $logfile."
	else
		show_error "$program encountered $errors errors. You might want to run $program again with logging enabled and report if there are any bugs."
	fi
fi
clean_temp
show_func "Completed."
[[ "$interactive" = "no" ]] || zenity --info --timeout="5" --title="Completed" --text="Completed. Click Ok to exit."
exit 0
}
