# Name: Enable DVD playback
# Command: enable_dvd
# Value: False

enable_dvd() {
show_func "Installing DVD codecs"
if [[ -d /usr/share/doc/libdvdread* && -d /usr/share/doc/libdvdnav* && -d /usr/share/doc/lsdvd* ]]; then
show_status "GStreamer plugins already installed"
else
rpmfusionrepo
install_pkg libdvdread libdvdnav lsdvd
fi
show_func "Installing libdvdcss2"
if [[ -f /usr/lib/libdvdcss.so.2 ]]; then
show_status "libdvdcss2 already installed"
else
file32="libdvdcss2-1.2.11-6.fc17.i686.rpm"
get32="http://dl.atrpms.net/all/libdvdcss2-1.2.11-6.fc17.i686.rpm"
file64="libdvdcss2-1.2.11-6.fc17.x86_64.rpm"
get64="http://dl.atrpms.net/all/libdvdcss2-1.2.11-6.fc17.x86_64.rpm"
process_pkg
fi
[[ -d /usr/share/doc/libdvdread* && -d /usr/share/doc/libdvdnav* && -d /usr/share/doc/lsdvd* && -f /usr/lib/libdvdcss.so.2 ]]; exit_state
}
