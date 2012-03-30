function S_F_ShellGPaste # Install GPaste clipboard manager
{
ShellGPaste
}

function ShellGPaste()
{
ShowFunc "Installing GPaste"
if [ -d /usr/share/gnome-shell/extensions/GPaste@gnome-shell-extensions.gnome.org ]; then
StatusMsg "GPaste already installed"
else
InstallGIT
InstallGTKDev
WarnMsg "We need to compile GPaste from source. It may take a while. Please be patient"
git clone https://github.com/Keruspe/GPaste.git
cd GPaste
./autogen.sh
./configure --prefix=/usr --sysconfdir=/etc
make
make install
cd ..
fi
if [ -d /usr/share/gnome-shell/extensions/GPaste@gnome-shell-extensions.gnome.org ]; then
Success
else
Failure
fi
}
