function P_F_FixFonts # Fix font smoothing
{
FixFonts
}

function FixFonts()
{
ShowFunc "Fixing font smoothing"
if [ ! -e /etc/fonts/conf.d/10-autohint.conf ]; then
ln -s /etc/fonts/conf.avail/10-autohint.conf /etc/fonts/conf.d/
fi
if [ ! -e /etc/fonts/conf.d/10-sub-pixel-rgb.conf ]; then
ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
fi
cat <<EOF | tee "$HOMEDIR/.fonts.conf"
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <match target="font">
 <edit name="autohint" mode="assign">
 <bool>true</bool>
 </edit>
 </match>
</fontconfig>
EOF
if [ -e "$HOMEDIR/.fonts.conf" ]; then
Success
else
Failure
fi
}
