function Notify()
{
sudo -u "$USER" notify-send -i "fedorautils" "$@"
}

function ErrorMsg()
{
echo -e $RED"$@"$ENDCOLOR
Notify "Error:" "$@"
return 1
}

function WarnMsg()
{
echo -e $YELLOW"$@"$ENDCOLOR
Notify "Warning:" "$@"
}

function StatusMsg()
{
echo -e $GREEN"$@"$ENDCOLOR
}

function ShowMsg()
{
echo -e $BLUE"$@"$ENDCOLOR
}

function ShowFunc()
{
echo -e $BLUEBOLD"$@"$ENDCOLOR
}

function Success()
{
echo -e $GREENBOLD"Successfully completed."$ENDCOLOR
return 0
}

function Failure()
{
echo -e $REDBOLD"Completed, but with errors!"$ENDCOLOR
ERRORS=$((ERRORS+1))
return 1
}
