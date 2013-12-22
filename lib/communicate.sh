show_err() {
echo -e $RED"$@"$ENDCOLOR
return 1
}

show_warn() {
echo -e $YELLOW"$@"$ENDCOLOR
}

show_status() {
echo -e $GREEN"$@"$ENDCOLOR
}

show_msg() {
echo -e $BLUE"$@"$ENDCOLOR
}

show_func() {
echo -e $BLUEBOLD"$@"$ENDCOLOR
}

show_dialog() {
yad --center --name="$program" --class="fedorautils" --window-icon="fedorautils" --borders="10" "$@"
}

exit_state() {
if [[ $? -eq 0 ]]; then
    echo -e $GREENBOLD"Successfully completed!"$ENDCOLOR
else
    echo -e $REDBOLD"Completed, but with errors!"$ENDCOLOR
    errors=$((errors+1))
fi
}
