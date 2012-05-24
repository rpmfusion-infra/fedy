function Chooser()
{
PREFIX="$1"
LISTTYPE="$2"
TITLE="$3"
changes=`
	IFS=$'\n'
	NAME=( $(awk -F'#|^function ' '/^function '$PREFIX'/{name=$2;
	{if(match(name, "T_")){print "TRUE"} else {print "FALSE"}};
	print name;desc=$3;
	{if(desc==""){print name} else {print desc}}};' $PLUGINS) )

	unset IFS

	zenity $LISTTYPE --width=450 --height=650 --title="$TITLE" --text=""	--list --column="Select" --column="Function" --column="Description" "${NAME[@]}" --hide-column=2 --hide-header --ok-label="Select" --cancel-label="Back"`
	if [ $? = 0 ]; then
	fun=$(echo $changes | tr "|" "\n")
	for x in $fun 
	do
		${x}
	done
	fi
Main
}
