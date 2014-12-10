# Run: check_req

check_req() {
show_func "Verifying minimum system requirements"
# Check distro
if [[ -f /etc/fedora-release ]]; then
    fver="$(rpm -E %fedora)"
    show_msg "Fedora version $fver detected"
else
    if [[ "$forcedistro" = "true" ]]; then
        show_warn "Unsupported distro, but will continue as instructed"
    else
        show_err "Distro not supported!"
        terminate_program
    fi
fi
# Check architecture
case `uname -m` in
    i386|i486|i586|i686)
        arch="32"
        show_status "Architecture verified (32-bit)";;
    x86_64)
        arch="64"
        show_status "Architecture verified (64-bit)";;
    *)
        show_err "Architecture not supported!"
        terminate_program;;
esac
# Check internet connection
if [[ `command -v $downagent` ]]; then
    get_file_quiet http://www.google.com /dev/null
else
    ping -c 1 www.google.com > /dev/null 2>&1
fi
if [[ $? -eq 0 ]]; then
    show_status "Internet connection verified"
else
    show_warn "Couldn't verify internet connection"
    [[ `command -v yad` && "$interactive" = "false" ]] || show_dialog --timeout="5" --title="Couldn't verify internet connection" --text="$program requires internet connection to work properly.\nYou may encounter problems. If you are using a proxy, configure it in $sysconf." --button="Continue:0"
fi
# Check required packages
reqpkgs=( "curl" "wget" "yad" )
for pkg in ${reqpkgs[@]}; do
    if [[ ! `command -v $pkg` ]]; then
        show_err "$pkg is required for $program to run properly, installing $pkg"
        install_pkg $pkg
        if [[ ! `command -v $pkg` ]]; then
            show_err "Installation of $pkg failed!"
            terminate_program
        fi
    fi
done
}
