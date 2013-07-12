# Name: Fedora People repositories
# Command: list_fedorapeople

list_fedorapeople() {
unset repolist
show_msg "Fetching repo list..."
get_file_quiet "http://repos.fedorapeople.org/index.html" "index.html"
repourls=($(cat "index.html" | tr ' ' '\n' | grep "fedora-$fver" | grep .*http\:\/\/repos.fedorapeople.org\/repos\/.*\.repo.* | cut -d\' -f 2 | uniq))
for repourl in ${repourls[@]}; do
	repoup=${repourl%/*.repo}
	repofile=${repourl##*/}
	reponame=$(grep "\"$repoup\"" index.html | tail -n 1 | cut -d\" -f 3 | sed -e 's/^>//g' -e 's/<\/a>//g' -e 's/<\/td>//g')
	repodesc=$(grep -A1 "\"$repoup\"" index.html | tail -n 1 | sed -e 's/^[ \t]*//' -e 's/<td>//g' -e 's/<\/td>//g')
	if [[ -f /etc/yum.repos.d/$repofile ]]; then
		repostat="Added"
	else
		repostat="Not added"
	fi
	repolist=( "${repolist[@]}" FALSE "$repourl" "$reponame" "$repodesc" "$repostat" )
done
while repos=$(zenity --list --checklist --width=900 --height=600 --title="Fedora People repositories" --text="The following repositories are listed from repos.fedorapeople.org and are unofficial. Add them at your own risk." --hide-header --column "Select" --column "URL" --column "Name" --column "Description" --column "Status" --hide-column="2" --ok-label="Add selected" --cancel-label="Back" "${repolist[@]}"); do
	selrepo=$(echo $repos | tr "|" "\n")
	zenity --question --title="Add repositories?" --text="The repositories are not verified and no gurrantee is provided for the packages in the repos. We take no responsibility if they break your system. Add them anyways?" --ok-label "Add repos" --cancel-label "Cancel"
	if [[ $? -eq 0 ]]; then
		for repourl in $selrepo; do
			repofile=${repourl##*/}
			show_msg "Adding $repofile"
			if [[ -f /etc/yum.repos.d/$repofile ]]; then
				show_status "$repofile already present"
			else
				get_file_quiet "$repourl" "$repofile"
				mv -f "$repofile" /etc/yum.repos.d/
			fi
			[[ -f /etc/yum.repos.d/$repofile ]]; exit_state
		done
	fi
done
}
