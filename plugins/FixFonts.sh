function P_F_FixFonts # Fix font smoothing
{
FixFonts
}

function FixFonts()
{
ShowFunc "Fixing font smoothing"
sudo -u "$USER" gsettings "set" "org.gnome.settings-daemon.plugins.xsettings" "antialiasing" "rgba"
sudo -u "$USER" gsettings "set" "org.gnome.settings-daemon.plugins.xsettings" "hinting" "slight"
echo "Xft.lcdfilter: lcddefault" > "$HOMEDIR/.Xresources"
if [ -d /usr/share/doc/freetype-freeworld* ]; then
StatusMsg "Freetype font rendering engine already installed"
else
InstallPkg freetype-freeworld
fi
f=`cat "$HOMEDIR/.Xresources" | grep "Xft.lcdfilter: lcddefault"`
if [ -n "$f" ] && [ -d /usr/share/doc/freetype-freeworld* ]; then
Success
else
Failure
fi
}
