build_repolist() {
unset repolist repodir boolean
repodir="$1"
boolean="$2"
repofiles=($(ls "$repodir"))
for repofile in ${repofiles[@]}; do
    repodesc=$(grep "name=" "$repodir/$repofile" | head -n 1 | sed -e 's/^name=//g' -e s/\$releasever/$fver/g -e s/\$basearch/$(uname -i)/g)
    repolist=( "${repolist[@]}" TRUE "$repofile" "$repodesc" )
done
}
