check_repo() {
yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -ix "${1%.repo}" > /dev/null 2>&1
}

test_repo() {
get_file_quiet "$(yum -q repoinfo ${1%.repo} 2>&1 | grep Repo-baseurl | grep -o 'https\?://.*' | sed -e 's/$/repodata\/repomd.xml/')" /dev/null
}

config_repo() {
repouri="$1"
repofile=${repouri##*/}
show_msg "Adding $repouri"
get_file_quiet "$repouri" "$repofile"
if [[ `grep "^name=" "$repofile"` && `grep "^#\?baseurl=" "$repofile"` ]]; then
    check_repo "$repofile"
    if [[ $? -eq 0 ]]; then
        show_status "$repofile already configured"
    else
        yum-config-manager --add-repo="$repouri"
        exit_state
    fi
else
    show_err "$repofile is malformed"
fi
}

add_repo() {
while [[ $# -gt 0 ]]; do
    if [[ $1 =~ .repo$ ]]; then
        repofile="$1"
        show_msg "Adding $repofile"
        check_repo "$repofile"
        if [[ $? -eq 0 ]]; then
            show_status "$repofile already configured"
        else
            eval "$repofile"
        fi
        test_repo "$repofile"
        if [[ ! $? -eq 0 ]]; then
            show_warn "$repofile is currently not available"
            reponame="${repofile%.repo}"
            yum-config-manager --save --setopt="${reponame}.skip_if_unavailable=1" --setopt="${reponame^}.skip_if_unavailable=1" > /dev/null 2>&1
        fi
    fi
    shift
done
}

remove_repo() {
while [[ $# -gt 0 ]]; do
    if [[ $1 =~ .repo$ ]]; then
        repofile="$1"
        rm -f "/etc/yum.repos.d/$repofile"
    fi
    shift
done
}
