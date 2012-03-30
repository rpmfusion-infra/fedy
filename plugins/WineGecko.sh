function U_F_SetupWine # Install wine with gecko
{
SetupWine
}

function SetupWine()
{
InstallWine
WineGecko
}

function InstallWine()
{
ShowFunc "Installing wine"
RPMFusion
if [ -d /usr/lib/wine ]; then
StatusMsg "wine already installed"
else
InstallPkg wine
fi
if [ -d /usr/lib/wine ]; then
Success
else
Failure
fi
}

function WineGecko()
{
ShowFunc "Installing wine gecko"
if [ -f /usr/share/wine/gecko/wine_gecko* ]; then
StatusMsg "wine gecko already installed"
else
	if [ $(uname -i) = "i386" ]; then
	file="wine_gecko-1.5-x86.msi"
	get="http://downloads.sourceforge.net/wine/wine_gecko-1.5-x86.msi"
	GetFile
	mkdir -p /usr/share/wine/gecko
	cp "$file" /usr/share/wine/gecko/
	elif [ $(uname -i) = "x86_64" ]; then
	file="wine_gecko-1.5-x86_64.msi"
	get="http://downloads.sourceforge.net/wine/wine_gecko-1.5-x86_64.msi"
	GetFile
	mkdir -p /usr/share/wine/gecko
	cp "$file" /usr/share/wine/gecko/
	fi
fi
if [ -f /usr/share/wine/gecko/wine_gecko* ]; then
Success
else
Failure
fi
}
