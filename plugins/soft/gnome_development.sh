# Name: Install GNOME development tools
# Command: gnome_development

devtoolslist=( "boost-devel" "bzip2-devel" "clutter-devel" "cvs" "cyrus-sasl-devel" "devhelp" "d-feet" "diffstat" "doxygen" "gdb" "gettext" "git" "gnome-common" "gobject-introspection" "gtkparasite" "koji" "krb5-devel" "mock" "ncurses-devel" "openldap-devel" "pam-devel" "patchutils" "perl-devel" "python-devel" "python-ldap" "rcs" "readline-devel" "redhat-rpm-config" "rpmdevtools" "slang-devel" "subversion" "systemtap" "valgrind" "zlib-devel" )

gnome_development() {
show_func "Installing GNOME development tools"
if [[ "$(gnome_development_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "GNOME development tools already installed"
else
    install_pkg @development-libs @development-tools @gnome-software-development @rpm-development-tools bzr bzrtools fedora-packager vala vala-devel vala-tools vala-doc
fi
[[ "$(gnome_development_test)" = "Installed" ]]; exit_state
}

gnome_development_undo() {
show_func "Uninstalling GNOME development tools"
erase_pkg @development-libs @development-tools @gnome-software-development @rpm-development-tools bzr bzrtools fedora-packager vala vala-devel vala-tools vala-doc
[[ ! "$(gnome_development_test)" = "Installed" ]]; exit_state
}

gnome_development_test() {
for devtool in ${devtoolslist[@]}; do
    ls /usr/share/doc/$devtool* > /dev/null 2>&1
    if [[ ! $? -eq 0 ]]; then
        devtoolsinstalled="no"
        break
    fi
done
if [[ ! "$devtoolsinstalled" = "no" ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
