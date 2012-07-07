check_lock() {
# Check for existing lockfile
if [ -e "$lockfile" ]; then
	if [ ! -r "$lockfile" ]; then
	show_error "Cannot open lockfile!"
	exit 1;
	fi
	pid=`cat "$lockfile"`
	kill -0 "$pid" 2>/dev/null
	if [ $? = "0" ]; then
	show_error "Another instance of $program is already running!"
	exit 1;
	fi
	# Process that created lockfile is no longer running - delete lockfile
	rm -f "$lockfile"
	if [ ! $? = "0" ]; then
	exit 1;
	fi
fi
# Create lockfile
echo $$ >"$lockfile"
if [ ! $? = "0" ]; then
	exit 1;
fi
}
