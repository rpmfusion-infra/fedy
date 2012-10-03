terminate_program() {
clean_temp
show_error "Program terminated."
[[ "$keeplog" = "yes" && -f "$logfile" ]] && show_error "Check log at "$logfile"."
[[ "$interactive" = "no" ]] || zenity --warning --text="Program terminated. Click Ok to exit."
exit 1
}
