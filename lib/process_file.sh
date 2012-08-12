install_pkg() {
yum -y install --nogpgcheck "$@"
}

install_local() {
yum -y localinstall --nogpgcheck "$@"
}

process_pkg() {
if [[ $(uname -i) = "i386" ]]; then
file="$file32"
get="$get32"
elif [[ $(uname -i) = "x86_64" ]]; then
file="$file64"
get="$get64"
fi
get_file
install_local "$file"
}
