complete_program() {
if [ ! "$errors" = "0" ]; then
	if [ "$keeplog" = "no" ]; then
	show_error "$program encountered $errors errors. You might want to run $program again with logging enabled and report if there are any bugs."
	else
	notify_send "Errors detected:" "$program encountered $errors errors. Please report bugs at http://github.com/satya164/fedorautils/issues. Please also attach the logfile $logfile."
	fi
fi
clean_temp
show_func "Completed."
zenity --info --timeout="5" --text="Completed. Click Ok to exit."
exit 0;
}
