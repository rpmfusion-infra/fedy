terminate_program() {
clean_temp
show_error "Program terminated."
if [[ "$keeplog" = "yes" && -f "$logfile" ]] ; then
show_error "Check log at "$logfile"."
fi
zenity --warning --text="Program terminated. Click Ok to exit."
exit 1;
}
