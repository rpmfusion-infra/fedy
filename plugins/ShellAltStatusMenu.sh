function S_T_ShellAltStatusMenu # Install alternative status menu
{
ShellAltStatusMenu
}

function ShellAltStatusMenu()
{
ShowFunc "Installing Alternative status menu extension"
if [ -d /usr/share/gnome-shell/extensions/alternative-status-menu@gnome-shell-extensions.gcampax.github.com ]; then
StatusMsg "Alternative status menu extension is already installed"
else
InstallPkg gnome-shell-extensions-alternative-status-menu
fi
if [ -d /usr/share/gnome-shell/extensions/alternative-status-menu@gnome-shell-extensions.gcampax.github.com ]; then
Success
else
Failure
fi
}
