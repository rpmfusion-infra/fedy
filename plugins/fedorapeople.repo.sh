# Name: Fedora People repositories
# Command: list_fedorapeople

list_fedorapeople() {
list_fedorapeople_build
while repos=$(zenity --list --checklist --width=900 --height=600 --title="Fedora People repositories" --text="The following repositories are listed from repos.fedorapeople.org and are unofficial. Add them at your own risk." --hide-header --column "Select" --column "URL" --column "Name" --column "Description" --column "Status" --hide-column="2" --ok-label="Add selected" --cancel-label="Back" "${repolist[@]}"); do
	selrepo=$(echo $repos | tr "|" "\n")
	for repourl in $selrepo; do
		repofile=${repourl##*/}
		show_msg "Adding $repofile"
		yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -w "${repofile%.repo}" > /dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			show_status "$repofile already configured"
		else
			get_file_quiet "$repourl" "$repofile"
			mv -f "$repofile" /etc/yum.repos.d/
			exit_state
		fi
	done
	list_fedorapeople_build
done
}

list_fedorapeople_build() {
unset repolist
show_msg "Fetching repo list..."
get_file_quiet "http://repos.fedorapeople.org/index.html" "index.html"
repourls=($(cat "index.html" | tr ' ' '\n' | grep "fedora-$fver" | grep .*http\:\/\/repos.fedorapeople.org\/repos\/.*\.repo.* | cut -d\' -f 2 | uniq))
for repourl in ${repourls[@]}; do
	repoup=${repourl%/*.repo}
	repofile=${repourl##*/}
	reponame=$(grep "\"$repoup\"" index.html | tail -n 1 | cut -d\" -f 3 | sed -e 's/^>//g' -e 's/<\/a>//g' -e 's/<\/td>//g')
	repodesc=$(grep -A1 "\"$repoup\"" index.html | tail -n 1 | sed -e 's/^[ \t]*//' -e 's/<td>//g' -e 's/<\/td>//g')
	yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -w "${repofile%.repo}" > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		repostat="Added"
	else
		repostat="Not added"
	fi
	repolist=( "${repolist[@]}" FALSE "$repourl" "$reponame" "$repodesc" "$repostat" )
done
}
