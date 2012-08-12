# Name: Install GTalk plugin
# Command: install_gtalk
# Value: False

install_gtalk() {
show_func "Installing GTalk plugin"
if [[ -d /opt/google/talkpluginh ]]; then
show_status "GTalk plugin already installed"
else
file32="google-talkplugin_current_i386.rpm"
get32="http://dl.google.com/linux/direct/google-talkplugin_current_i386.rpm"
file64="google-talkplugin_current_x86_64.rpm"
get64="http://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm"
process_pkg
fi
[[ -d /opt/google/talkplugin ]]; exit_state
}
