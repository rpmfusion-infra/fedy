# Name: Install essential software
# Command: essential_soft
# Value: True

essential_soft() {
show_func "Installing essential software"
if [[ -e /usr/bin/cabextract && -e /usr/bin/dconf-editor && -d /usr/share/doc/p7zip-plugins* && -e /usr/bin/wget && -e /usr/bin/lzma && -e /usr/bin/unrar && -e /usr/lib/yum-plugins/fastestmirror.py ]]; then
show_status "Essential software already installed"
else
install_pkg cabextract dconf-editor p7zip p7zip-plugins wget xz-lzma-compat unrar yum-plugin-fastestmirror
fi
[[ -e /usr/bin/cabextract && -e /usr/bin/dconf-editor && -d /usr/share/doc/p7zip-plugins* && -e /usr/bin/wget && -e /usr/bin/lzma && -e /usr/bin/unrar && -e /usr/lib/yum-plugins/fastestmirror.py ]]; exit_state
}
