install_bzr() {
show_func "Installing bzr"
if [ `which bzr` ]; then
show_status "bzr already installed"
else
install_pkg bzr
fi
[ `which bzr` ]; exit_state
}

install_git() {
show_func "Installing git"
if [ `which git` ]; then
show_status "git already installed"
else
install_pkg git
fi
[ `which git` ]; exit_state
}

function install_gtkdev() {
show_func "Installing developement packages for GTK3"
install_pkg dbus-glib-devel glib2-devel gnome-common gtk3-devel intltool automake autoconf vala
exit_state
}
