install_pkg() {
yum -y install --nogpgcheck --skip-broken "$@"
}

install_pkg_prevrel() {
test_repo "$1"
if [[ $? -eq 0 || ! "$tryprevrel" = "yes" ]]; then
    install_pkg "${@:2}"
else
    show_msg "Trying with Fedora $((fver-1)) repo"
    install_pkg --releasever="$((fver-1))" "${@:2}"
fi
}

update_pkg() {
yum -y update --nogpgcheck --skip-broken "$@"
}

process_pkg() {
if [[ "$arch" = "32" ]]; then
    file="$file32"
    get="$get32"
elif [[ "$arch" = "64" ]]; then
    file="$file64"
    get="$get64"
fi
get_file "$@"
[[ -f "$file" ]] && install_pkg "$file"
}

make_backup() {
if [[ "$keepbackup" = "yes" ]]; then
    [[ -f "$1" && ! -f "$1".bak ]] && cp -rf "$1" "$1".bak
fi
}
