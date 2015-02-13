# Name: Install IntelliJ IDEA Ultimate Edition
# Command: intellij_idea_ultimate
#
# Fedy plugin by Gabriel Bauman <gabe@codehaus.org>

intellij_idea_ultimate() {

	show_func "Installing IntelliJ IDEA Ultimate Edition"

	if [[ "$(intellij_idea_ultimate_test)" = "Installed" ]]; then
	
		show_status "IntelliJ IDEA Ultimate Edition is already installed"
		
	else
	
		# Install a JDK
		#
		yum install -y wget java-1.8.0-openjdk java-1.8.0-openjdk-devel

		# Work in /tmp
		cd /tmp
	
		# Download the latest version of IntelliJ Ultimate Edition. This is tricky ;)
		# Not using Fedy's download functions because we have to do a wacky POST request
		#
		wget \
			--user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0" \
			--post-data="os=linux&edition=IU" \
			--referer="http://www.jetbrains.com/idea/download/" \
			--domains="jetbrains.com" \
			--https-only \
			--span-hosts \
			--accept=".tar.gz" \
			--recursive --level=1 \
			-np -nd -erobots=off \
			-c "http://www.jetbrains.com/idea/download/download_thanks.jsp"
	
		TARBALL=$(ls ideaIU-*.tar.gz)
	
		# Unpack IntelliJ into /opt
		#
		tar -xzf $(ls $TARBALL) -C /opt
	
		# Rename the IntelliJ home directory
		#
		mv /opt/idea-IU* /opt/intellij-idea-ultimate
	
		# Create a desktop file so the app can be launched from GNOME Shell
		#
		cat > /usr/local/share/applications/jetbrains-idea.desktop <<-DESKTOPFILE
		[Desktop Entry]
		Version=1.0
		Type=Application
		Name=IntelliJ IDEA
		Icon=/opt/intellij-idea-ultimate/bin/idea.png
		Exec="/opt/intellij-idea-ultimate/bin/idea.sh" %f
		Comment=Develop with pleasure!
		Categories=Development;IDE;
		Terminal=false
		StartupWMClass=jetbrains-idea	
		DESKTOPFILE
	
		# Remove the tarball from /tmp
		#
		rm -f $TARBALL	
	fi	
	
	[[ "$(intellij_idea_ultimate_test)" = "Installed" ]]; exit_state

}

intellij_idea_ultimate_test() {

	if [[ -x /opt/intellij-idea-ultimate/bin/idea.sh ]]; then
		printf "Installed"
	else
		printf "Not installed"
	fi
	
}

intellij_idea_ultimate_undo() {

	show_func "Uninstalling IntelliJ IDEA Ultimate Edition"

	rm -rf /opt/intellij-idea-ultimate
	rm -f /usr/local/share/applications/jetbrains-idea.desktop
	
	[[ ! "$(intellij_idea_ultimate_test)" = "Installed" ]]; exit_state
	
}

