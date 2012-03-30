function S_F_ShellMediaPlayer # Install Media player extension
{
ShellMediaPlayer
}

function ShellMediaPlayer()
{
ShowFunc "Installing Media player extension"
if [ -d /usr/share/gnome-shell/extensions/mediaplayer@patapon.info ]; then
StatusMsg "Media player extension already installed"
else
InstallGIT
InstallGTKDev
WarnMsg "We need to compile Media player extension from source. It may take a while. Please be patient"
git clone https://github.com/eonpatapon/gnome-shell-extensions-mediaplayer.git
cd gnome-shell-extensions-mediaplayer
./autogen.sh --prefix=/usr
make
make install
cd ..
fi
if [ -d /usr/share/gnome-shell/extensions/mediaplayer@patapon.info ]; then
Success
else
Failure
fi
}
