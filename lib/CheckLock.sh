function CheckLock()
{
# Check for existing lockfile
if [ -e "$LOCKFILE" ]; then
	if [ ! -r "$LOCKFILE" ]; then
	ErrorMsg "Cannot open lockfile!"
	exit 1;
	fi
	PID=`cat "$LOCKFILE"`
	kill -0 "$PID" 2>/dev/null
	if [ $? = "0" ]; then
	ErrorMsg "Another instance of $PROGRAM is already running!"
	exit 1;
	fi
	# Process that created lockfile is no longer running - delete lockfile
	rm -f "$LOCKFILE"
	if [ ! $? = "0" ]; then
	exit 1;
	fi
fi
# Create lockfile
echo $$ >"$LOCKFILE"
if [ ! $? = "0" ]; then
   exit 1;
fi
}
