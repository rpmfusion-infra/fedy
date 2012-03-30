function U_T_CoreFonts # Install Microsoft core fonts
{
CoreFonts
}

function CoreFonts()
{
ShowFunc "Installing Microsoft Truetype fonts"
if [ -d /usr/share/fonts/msttcorefonts ]; then
StatusMsg "Microsoft Truetype fonts already installed"
else
if [ ! -e /usr/bin/cabextract ]; then
InstallPkg cabextract
fi
mkdir -p "$WORKINGDIR/corefonts"
ProcessFont andale32.exe
ProcessFont arialb32.exe
ProcessFont arial32.exe
ProcessFont comic32.exe
ProcessFont courie32.exe
ProcessFont georgi32.exe
ProcessFont impact32.exe
ProcessFont times32.exe
ProcessFont trebuc32.exe
ProcessFont verdan32.exe
ProcessFont webdin32.exe
mv "$WORKINGDIR/msttcorefonts" "/usr/share/fonts/"
ShowMsg "Rebuilding font cache..."
fc-cache -f -v
fi
if [ -d /usr/share/fonts/msttcorefonts ]; then
Success
else
Failure
fi
}

function ProcessFont()
{
font="$1"
fontfile="$WORKINGDIR/corefonts/$font"
if [ ! -f "$fontfile" ] || [ $FORCE = "YES" ]; then
ShowMsg "Downloading $font..."
curl -L -# "http://downloads.sourceforge.net/corefonts/$font" -o "$fontfile"
fi
cabextract -L -d "$WORKINGDIR/msttcorefonts" "$fontfile"
if [ "$KEEPDOWNLOADS" = "YES" ]; then
mkdir -p "$DOWNLOADSDIR/corefonts/"
cp -f "$fontfile" "$DOWNLOADSDIR/corefonts/"
fi
}
