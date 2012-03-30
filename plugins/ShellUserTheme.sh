function S_T_ShellUserTheme # Install user theme extension
{
ShellUserTheme
}

function ShellUserTheme()
{
ShowFunc "Installing user theme extension"
if [ -d /usr/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com ]; then
StatusMsg "User theme extension is already installed"
else
InstallPkg gnome-shell-extensions-user-theme
fi
if [ -d /usr/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com ]; then
Success
else
Failure
fi
}
