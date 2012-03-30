function Terminate()
{
CleanTemp
ErrorMsg "Program terminated."
if [ "$KEEPLOG" = "YES" ]; then
ErrorMsg "Check log at "$LOGFILE"."
fi
zenity --warning --text="Program terminated. Click Ok to exit."
exit 1;
}
