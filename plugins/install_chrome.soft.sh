# Name: Install Google Chrome
# Command: install_chrome
# Value: False

install_chrome() {
show_func "Installing Google Chrome"
if [[ -d /opt/google/chrome ]]; then
show_status "Google Chrome already installed"
else
file32="google-chrome-stable_current_i386.rpm"
get32="https://dl.google.com/linux/direct/google-chrome-stable_current_i386.rpm"
file64="google-chrome-stable_current_x86_64.rpm"
get64="http://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
process_pkg
fi
[[ -d /opt/google/chrome ]]; exit_state
}
