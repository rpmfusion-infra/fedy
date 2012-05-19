function Complete()
{
if [ "$REBOOTREQUIRED" = "YES" ]; then
WarnMsg "You might need to Reboot to apply all changes"
fi
if [ ! "$ERRORS" = "0" ]; then
ErrorMsg "$PROGRAM encountered $ERRORS errors. You might want to run $PROGRAM again with logging enabled and report if there are any bugs."
fi
CleanTemp
ShowFunc "Completed."
zenity --info --timeout="5" --text="Completed. Click Ok to exit."
exit 0;
}
