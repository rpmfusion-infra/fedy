check_lock() {
# Check for existing lockfile
if [[ -e "$lockfile" ]]; then
	if [[ ! -r "$lockfile" ]]; then
		show_error "Cannot open lockfile!"
		terminate_program
	fi
	pid=`cat "$lockfile"`
	kill -0 "$pid" 2>/dev/null
	if [[ $? -eq 0 ]]; then
		show_error "Another instance of $program is already running!"
		terminate_program
	fi
	# Process that created lockfile is no longer running - delete lockfile
	rm -f "$lockfile"
	[[ $? -eq 0 ]] || terminate_program
fi
# Create lockfile
echo $$ > "$lockfile"
[[ $? -eq 0 ]] || terminate_program
}
