function I_F_InstallArista # Install Arista Transcoder
{
InstallArista
}

function InstallArista()
{
ShowFunc "Installing Arista Transcoder"
if [ -e /usr/bin/arista-gtk ]; then
StatusMsg "Arista Transcoder already installed"
else
InstallPkg python2-devel python3-devel gstreamer-plugins-bad-nonfree
file="arista-0.9.7.tar.gz"
get="http://programmer-art.org/media/releases/arista-transcoder/arista-0.9.7.tar.gz"
GetFile
tar -xvf "$file"
cd arista-0.9.7
python setup.py build
python setup.py install
fi
if [ -e /usr/bin/arista-gtk ]; then
Success
else
Failure
fi
}
