#!/bin/bash

cat > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf <<EOF
Section "InputClass"
	Identifier "Fedy Mouse Configuration - Disable mouse acceleration"
	MatchIsPointer "yes"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "-1"
EndSection
EOF
