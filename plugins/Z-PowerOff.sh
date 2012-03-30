function U_F_PowerOff # Power off system when done
{
PowerOff
}

function PowerOff()
{
CleanTemp
WarnMsg "The system will be powered off in 10 seconds. Press any key to cancel shutdown."
if read -n1 -t10 any_key; then
ShowMsg "Shutdown cancelled!"
Complete
else
ShowMsg "Shutting down system"
shutdown -h now
fi
exit 0;
}
