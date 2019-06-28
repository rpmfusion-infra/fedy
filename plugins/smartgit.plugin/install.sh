#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

CACHEDIR="/var/cache/fedy/smartgit-generic";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

FILE=smartgit-linux-$(wget "https://www.syntevo.com/smartgit/changelog.txt" -O - |  sed -n '1{s/SmartGit \([0-9][0-9]*\)\.\([0-9][0-9]*\)\.\([0-9][0-9]*\) .*/\1_\2_\3/ ; p}').tar.gz
URL=http://www.syntevo.com/downloads/smartgit/$FILE

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

ln -sf "/opt/smartgit/bin/smartgit.sh" "/usr/bin/smartgit"
/opt/smartgit/bin/add-menuitem.sh
