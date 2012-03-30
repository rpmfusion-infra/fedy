function Main()
{
main=`
	IFS=$'\n'
	NAME=( $(awk -F'#|^function ' '/^function/{name=$2;
	{print"FALSE"};print name;desc=$3;
	{if(desc==""){print name} else {print desc}}};' $MODULES) )

	unset IFS

	zenity --list --radiolist --width=300 --height=350 --title="$PROGRAM $VERSION" --text="Welcome to $PROGRAM. Please choose an option." --column "Select" --column "Function" --column "Options" "${NAME[@]}" --hide-column=2 --hide-header --ok-label="Select" --cancel-label="Close"`
	if [ $? = 0 ]; then
	fun=$(echo $main | tr "|" "\n")
	for x in $fun 
	do
		${x}
	done
	fi
Complete
}
