function S_F_ShellPidginNotifier # Install Pidgin notifier extension
{
ShellPidginNotifier
}

function ShellPidginNotifier()
{
ShowFunc "Installing Pidgin notifier extension"
if [ -d /usr/share/gnome-shell/extensions/pidgin@gnome-shell-extensions.gnome.org ]; then
StatusMsg "Pidgin notifier extension is already installed"
else
InstallGIT
git clone https://github.com/kagesenshi/gnome-shell-extensions-pidgin.git
mv gnome-shell-extensions-pidgin /usr/share/gnome-shell/extensions/pidgin@gnome-shell-extensions.gnome.org
fi
if [ -d /usr/share/gnome-shell/extensions/pidgin@gnome-shell-extensions.gnome.org ]; then
Success
else
Failure
fi
}
