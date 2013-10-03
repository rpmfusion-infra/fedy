build_repolist() {
unset repolist repodir boolean
repodir="$1"
boolean="$2"
repofiles=($(ls "$repodir"))
for repofile in ${repofiles[@]}; do
    if [[ `grep "enabled=0" "$repodir/$repofile"` ]]; then
        repostat="Disabled"
        check="FALSE"
    else
        repostat="Enabled"
        check="TRUE"
    fi
    if [[ "$boolean" = "true" ]]; then
        check="TRUE"
    elif [[ "$boolean" = "false" ]]; then
        check="FALSE"
    fi
    repodesc=$(grep "name=" "$repodir/$repofile" | head -n 1 | sed -e 's/^name=//g' -e s/\$releasever/$fver/g -e s/\$basearch/$(uname -i)/g)
    repolist=( "${repolist[@]}" "$check" "$repofile" "$repodesc" "$repostat" )
done
}
