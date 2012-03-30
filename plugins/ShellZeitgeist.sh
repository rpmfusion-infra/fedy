function S_F_ShellZeitgeist # Install Zeitgeist extension
{
ShellZeitgeist
}

function ShellZeitgeist()
{
ShowFunc "Installing Zeitgeist extension"
if [ -d /usr/share/gnome-shell/extensions/gimmie@gnome-shell-extensions.gnome.org ]; then
StatusMsg "Zeitgeist extension is already installed"
else
InstallPkg zeitgeist zeitgeist-datahub
file="gimmie@gnome-shell-extensions.gnome.org.zip"
get="http://dl.dropbox.com/u/7162902/gimmie@gnome-shell-extensions.gnome.org.zip"
GetFile
unzip "$file"
mv gimmie@gnome-shell-extensions.gnome.org /usr/share/gnome-shell/extensions/
fi
if [ -d /usr/share/gnome-shell/extensions/gimmie@gnome-shell-extensions.gnome.org ]; then
Success
else
Failure
fi
}
