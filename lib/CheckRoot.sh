function CheckRoot()
{
ShowFunc "Verifying root access"
if [ ! $(whoami) = "root" ]; then
	ErrorMsg "Root access is needed to run $PROGRAM"
	zenity --question --title="Root access needed!" -- text="$PROGRAM needs root access to work. Are you sure to continue?" --ok-label "Yes" --cancel-label "No"
	if [ $? == 1 ]; then
		Terminate
	else
		AddSudoer
		WarnMsg "Attempting to run $PROGRAM with root previleges, all arguements will reset"
		exec sudo $0 "$@"
		exit;
	fi
else
	StatusMsg "$USER registered as logged in User"
fi
}
