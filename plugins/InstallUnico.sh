function I_F_InstallUnico # Install Unico theme engine
{
InstallUnico
}

function InstallUnico()
{
ShowFunc "Installing Unico Theme Engine"
if [ -e /usr/lib/gtk-3.0/3.0.0/theming-engines/libunico.so ]; then
StatusMsg "Unico Theme Engine already installed"
else
InstallBZR
InstallGTKDev
	if [ "$fver" = "17" ]; then
	WarnMsg "We need to compile Unico Theme Engine from source. It may take a while. Please be patient"
	bzr branch lp:unico
	cd unico
	./autogen.sh
	./configure --prefix=/usr
	make
	make install
	cd ..
	else
	WarnMsg "Unico Theme Engine is not available for your Fedora version"
	fi
fi
if [ -e /usr/lib/gtk-3.0/3.0.0/theming-engines/libunico.so ]; then
Success
else
Failure
fi
}
