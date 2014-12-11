# Name: Install GNOME development tools
# Command: gnome_development

devtoolslist=( "boost-devel" "bzip2-devel" "clutter-devel" "cvs" "cyrus-sasl-devel" "devhelp" "diffstat" "doxygen" "gdb" "gettext" "git" "gnome-common" "gobject-introspection" "koji" "krb5-devel" "mock" "ncurses-devel" "openldap-devel" "pam-devel" "patchutils" "perl-devel" "python-devel" "python-ldap" "rcs" "readline-devel" "redhat-rpm-config" "rpmdevtools" "slang-devel" "subversion" "systemtap" "zlib-devel" )

gnome_development() {
show_func "Installing GNOME development tools"
if [[ "$(gnome_development_test)" = "Installed" ]]; then
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
query_pkg ${devtoolslist[@]}
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
