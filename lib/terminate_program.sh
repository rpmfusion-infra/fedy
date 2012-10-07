terminate_program() {
clean_temp
show_error "Program terminated."
[[ "$enablelog" = "yes" && -f "$logfile" ]] && show_error "Check log at "$logfile"."
[[ "$interactive" = "no" ]] || zenity --warning --title="Terminated" --text="Program terminated. Click Ok to exit."
exit 1
}
