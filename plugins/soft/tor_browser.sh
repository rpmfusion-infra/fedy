# Name: Install Tor Browser Bundle
# Command: tor_browser

tor_browser() {
show_func "Installing Tor Browser Bundle"
if [[ "$(tor_browser_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Tor Browser Bundle already installed"
else
    show_msg "Fetching webpage"
    get_file_quiet "http://www.torproject.org/projects/torbrowser.html.en" "tor.htm"
    get=$(cat "tor.htm" | tr ' ' '\n' | grep -o "/dist/torbrowser/.*/tor-browser-linux${arch}-.*_en-US.tar.xz" | head -n 1 | sed -e 's/^/http:\/\/www.torproject.org/')
    file=${get##*/}
    get_file
    show_msg "Installing files"
    tar -xJf "$file"
    cp -af "tor-browser_en-US" "/opt/"
    ln -sf "/opt/tor-browser_en-US/start-tor-browser" "/usr/bin/tor-browser"
cat <<EOF | tee /usr/share/applications/tor-browser.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Tor Browser
GenericName=Browse Anonymously
Icon=web-browser
Comment=Protect your privacy with Tor
Exec=tor-browser %u
Terminal=false
Type=Application
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
EOF
fi
[[ "$(tor_browser_test)" = "Installed" ]]; exit_state
}

tor_browser_undo() {
show_func "Uninstalling Tor Browser Bundle"
rm -f "/usr/bin/tor-browser"
rm -f "/usr/share/applications/tor-browser.desktop"
rm -rf "/opt/tor-browser_en-US"
[[ ! "$(tor_browser_test)" = "Installed" ]]; exit_state
}

tor_browser_test() {
if [[ -f /opt/tor-browser_en-US/start-tor-browser ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
