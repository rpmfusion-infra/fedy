# Run: check_lock

check_lock() {
# Check for existing lockfile
if [[ -e "$lockfile" ]]; then
    if [[ ! -r "$lockfile" ]]; then
        show_err "Cannot open lockfile!"
        terminate_program
    fi
    pid=`cat "$lockfile"`
    kill -0 "$pid" > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        show_err "Another instance of $program is already running!"
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
