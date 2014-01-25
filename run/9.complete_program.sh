# Run: complete_program

complete_program() {
clean_temp
if [[ ! "$errors" = "0" ]]; then
    if [[ $(whoami) = "root" && "$enablelog" = "yes" && -f "$logfile" ]]; then
        error_msg="Please report bugs at http://github.com/satya164/fez/issues along with the logfile $logfile. Use http://fpaste.org to post the logfile."
    else
        error_msg="You might want to run $program again with logging enabled and report if there are any bugs."
    fi
    show_err "$program encountered $errors error(s). $error_msg"
    [[ "$interactive" = "no" ]] || show_dialog --title="$errors error(s) occured" --text="$error_msg" --button="Close:0"
    exit 1
else
    exit 0
fi
}
