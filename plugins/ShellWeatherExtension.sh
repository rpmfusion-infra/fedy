function S_F_ShellWeatherExtension # Install Weather extension
{
ShellWeatherExtension
}

function ShellWeatherExtension()
{
ShowFunc "Installing Weather extension"
if [ -d /usr/share/gnome-shell/extensions/weather@gnome-shell-extensions.gnome.org ]; then
StatusMsg "Weather extension is already installed"
else
InstallGIT
InstallGTKDev
WarnMsg "We need to compile Weather extension from source. It may take a while. Please be patient"
git clone https://github.com/simon04/gnome-shell-extension-weather.git
cd gnome-shell-extension-weather
./autogen.sh
./configure --prefix=/usr
make
make install
cd ..
fi
if [ -d /usr/share/gnome-shell/extensions/weather@gnome-shell-extensions.gnome.org ]; then
Success
else
Failure
fi
}
