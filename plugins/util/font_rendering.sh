# Name: Improve font rendering
# Command: font_rendering

font_rendering() {
show_func "Improving font rendering"
if [[ "$(font_rendering_test)" = "Improved" ]]; then
    show_status "Font rendering already improved"
else
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
install_pkg freetype-freeworld
cat <<EOF | tee /etc/fonts/local.conf > /dev/null 2>&1
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <match target="pattern">
  <edit name="dpi" mode="assign">96</edit>
 </match>
 <match target="font">
  <edit mode="assign" name="antialias" >
  <bool>true</bool>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="hinting" >
  <bool>true</bool>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="hintstyle" >
  <const>hintslight</const>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="rgba" >
  <const>rgb</const>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="lcdfilter">
  <const>lcddefault</const>
  </edit>
 </match>
 </fontconfig>
EOF
fi
[[ "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_undo() {
show_func "Restoring original font rendering"
erase_pkg freetype-freeworld
rm -f /etc/fonts/local.conf
[[ ! "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_test() {
query_pkg freetype-freeworld
if [[ $? -eq 0 && -f /etc/fonts/local.conf ]]; then
    printf "Improved"
else
    printf "Not improved"
fi
}
