speak_tts() {
if [[ "$tts" = "yes" ]]; then
	echo "$@" | festival --tts
fi
}

notify_send() {
sudo -u "$user" notify-send -h int:transient:1 "$@"
}

show_progress() {
while true; do
	printf "."
	sleep 1
done
}

show_error() {
echo -e $RED"$@"$ENDCOLOR
notify_send -i dialog-error "Error:" "$@"
speak_tts "$@"
return 1
}

show_warn() {
echo -e $YELLOW"$@"$ENDCOLOR
notify_send -i dialog-warning "Warning:" "$@"
speak_tts "$@"
}

show_status() {
echo -e $GREEN"$@"$ENDCOLOR
}

show_msg()
{
echo -e $BLUE"$@"$ENDCOLOR
}

show_func()
{
echo -e $BLUEBOLD"$@"$ENDCOLOR
}

exit_state()
{
if [[ $? -eq 0 ]]; then
	echo -e $GREENBOLD"Successfully completed."$ENDCOLOR
else
	echo -e $REDBOLD"Completed, but with errors!"$ENDCOLOR
	errors=$((errors+1))
fi
}
