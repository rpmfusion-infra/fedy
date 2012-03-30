function ShowLogfile()
{
if [ -e "$LOGFILE" ]; then
	cat "$LOGFILE"
else
	echo -e "No logfile exists. Try running Fedora Utils with logging enabled. Use --help for more details"
fi
}
