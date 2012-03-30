function CleanTemp()
{
if [ -d "$WORKINGDIR" ]; then
rm -rf "$WORKINGDIR"
fi
if [ -d "$DOWNLOADSDIR" ]; then
chown -R "$USER" "$DOWNLOADSDIR"
# Delete Downloads directory if it is empty
rmdir --ignore-fail-on-non-empty $DOWNLOADSDIR
StatusMsg "Temporary directory cleaned"
fi
# Delete lockfile
if [ $(whoami) = "root" ]; then
	rm -f "$LOCKFILE"
	if [ $? != 0 ]; then
	   exit 1;
	fi
fi
}
