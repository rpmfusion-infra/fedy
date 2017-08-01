Name:           fedy
Version:        4.5.1
Release:        1%{?dist}
Summary:        Install codecs and additional software

Group:          System/Management
License:        GPLv3+
URL:            https://www.folkswithhats.org/
Source0:        https://github.com/folkswithhats/%{name}/archive/v%{version}/%{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  desktop-file-utils
BuildRequires:  libappstream-glib

# Obsoletes introduced in f26
Provides: fedy-core = %{version}-%{release}
Obsoletes: fedy-core < 4.5.1-1
Provides: fedy-plugins = %{version}-%{release}
Obsoletes: fedy-plugins < 4.5.1-1

Requires: dnf-plugins-core
Requires: gjs
Requires: gtk3
Requires: libnotify
Requires: rpmfusion-free-release
Requires: rpmfusion-nonfree-release
Requires: sed
Requires: tar
Requires: wget


%description
Fedy lets you install multimedia codecs and additional software that Fedora
doesn't want to ship, like mp3 support, Adobe Flash, Oracle Java etc., and
much more with just a few clicks.


%prep
%autosetup -p1


%build
#Nothing to build


%install
%make_install

# Validate desktop file
desktop-file-validate \
  %{buildroot}%{_datadir}/applications/*%{name}.desktop

# Validate appdata file
appstream-util validate-relax \
  %{buildroot}%{_datadir}/appdata/%{name}.appdata.xml


%files
%license COPYING
%doc CREDITS README.md
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/applications/*.%{name}.desktop
%{_datadir}/icons/hicolor/scalable/apps/%{name}.svg
%{_datadir}/icons/hicolor/scalable/apps/%{name}-symbolic.svg
%{_datadir}/polkit-1/actions/org.folkswithhats.pkexec.run-as-root.policy
%{_datadir}/appdata/%{name}.appdata.xml


%changelog
* Tue Aug 01 2017 Nicolas Chauvet <kwizart@gmail.com> - 4.5.1-1
- Update to 4.5.1
* Thu Jul 27 2017 Benjamin Denhartog <foss@bddenhartog.com> 4.5.1
- (d38f68d) devinshoe@gmail.com Install libXScrnSaver with GitKraken
* Mon Jul 24 2017 Nicolas Chauvet <kwizart@gmail.com> - 4.5.0-1
- Spec file clean-up
- Obsoletes fedy-plugins and fedy-gui
* Mon Jul 24 2017 Benjamin Denhartog <foss@bddenhartog.com> 4.5.0
- (c8f707e) adil452100@yahoo.fr Fix status command
- (5d7308d) adil452100@yahoo.fr Fix generated link
- (39cb1fc) kwizart@gmail.com Add flash-ppapi
- (fddd2a4) kwizart@gmail.com Disable Undeeded selinux tweak for steam
- (7c49af3) kwizart@gmail.com Add a dedicated plugin for virtualbox-guest
- (db7d1ea) kwizart@gmail.com VirtualBox : use dnf install and only hypervisor
- (b21a02d) kwizart@gmail.com Switch to using dnf groups for codecs
- (97d820f) kwizart@gmail.com HandBrake is now in RPM Fusion
- (ac230d9) kwizart@gmail.com Switch to livna for libdvdcss
- (9e28c15) kwizart@gmail.com Adobe Flash npapi plugin
- (7d2c5c8) bddenhartog@gmail.com refactor the logging done in the plugin for skype
* Mon Jul 17 2017 Benjamin Denhartog <foss@bddenhartog.com> 4.4.1
- (cfe64c9) foss@bddenhartog.com add swapfiles to git ignore
- (0cb09c6) foss@bddenhartog.com refactor skype plugin
* Sun Jul 16 2017 Benjamin Denhartog <foss@bddenhartog.com> 4.4.0
- (ce0b7e8) foss@bddenhartog.com refactor label for resilio sync
- (574914a) foss@bddenhartog.com refactor label and description for google play music desktop player
- (f81a195) foss@bddenhartog.com remove cerebro from plugins
- (971c5aa) foss@bddenhartog.com fix invalid status check for yatta plugin
- (b8877b1) foss@bddenhartog.com fix typo in 'quiet' option for rpm
- (0fe8f8a) foss@bddenhartog.com apply changes requested in review
- (a7a6338) j.r.downie@sms.ed.ac.uk Added RStudio plugin.
- (fc235c3) abhinavother@gmail.com Added wxHexEditor.
- (e964de1) abhinavother@gmail.com Adding Peazip.
- (257f173) abhinavother@gmail.com Add Cerebro, A system launcher.
- (64be9b1) abhinavother@gmail.com Adding Yatta Eclipes Launcher
- (675294a) abhinavother@gmail.com Added Google play #460
- (6f16b2c) abhinavother@gmail.com Fixed uncommited changes.
- (3fa5ae8) abhinavother@gmail.com Erase command has been depricated in F25.
- (1f3c596) abhinavother@gmail.com Updated VS-Code.
- (e0abbe8) abhinavother@gmail.com Telegram is now in fusion repos.
- (cbdc1ea) abhinavother@gmail.com Fix systemd bug.
- (fbd82a7) abhinavother@gmail.com Use official sublime text repos.
- (2de982b) abhinavother@gmail.com Steam is now in fusion repos.
- (1da582c) abhinavother@gmail.com Updated Smartgit with new URL pattern
- (94d1e34) abhinavother@gmail.com Updated to new Skype for linux.
- (2702b77) abhinavother@gmail.com Updating Virtualbox.
- (8a5964d) abhinavother@gmail.com Updated Flash plugin.
- (c910301) abhinavother@gmail.com Updated evopop theme
- (ec08509) abhinavother@gmail.com Replacing depricated erase with remove command
- (15aafc9) abhinavother@gmail.com Updated defunt Bittorrent-sync to Resilio-sync
- (9e9032d) abhinavother@gmail.com Switching Atom editor from outdated Mosquito copr to Official download
- (bffd3c1) abhinavother@gmail.com Update Arc themes.
- (16e18d4) abhinavother@gmail.com Erase command has been depricated in F25.
- (7313446) abhinavother@gmail.com Updated dependencies
* Sat Jun 10 2017 Benjamin Denhartog <foss@bddenhartog.com> 4.3.6
- Update plugins
* Tue Jan 17 2017 Bryan Hernandez <bryan27hr@protonmail.ch> 4.2.4
- Update plugins and bug fixes
* Tue Jan 03 2017 Bryan Hernandez <bryan27hr@protonmail.ch> 4.2.3
- Update plugins, Added support for F25.
* Thu Jun 23 2016 Abhinav Kulshreshtha <AbhinavOther@gmail.com> 4.2.1
- Release for F24
* Sun Feb 21 2016 Abhinav Kulshreshtha <AbhinavOther@gmail.com> 4.1.2
- Fix Several issues, Update plugins.
* Sun Jan 03 2016 Abhinav Kulshreshtha <AbhinavOther@gmail.com> 4.1.0
- Update packages. Remove support for F21.
* Wed Nov 11 2015 Abhinav Kulshreshtha <AbhinavOther@gmail.com> 4.0.9
- Update Packages.
* Tue Nov 03 2015 Abhinav Kulshreshtha <AbhinavOther@gmail.com> 4.0.8
- Release for Fedora 23. Updated packages.
* Tue Nov 03 2015 Abhinav Kulshreshtha <AbhinavOther@gmail.com> 4.0.8
- Updated packages. Now under FolksWithHats.org
* Wed May 27 2015 Satyajit Sahoo <satyajit.happy@gmail.com> 4.0.2
- split package into core and plugins
* Sun May 17 2015 Satyajit Sahoo <satyajit.happy@gmail.com> 4.0.0
- major rewrite
* Sun Jan 26 2014 Satyajit Sahoo <satyajit.happy@gmail.com> 3.1.6
- renamed to fedy
* Sun Jan 26 2014 Satyajit Sahoo <satyajit.happy@gmail.com> 3.1.5
- added fedy repo
* Tue Jul 23 2013 Satyajit Sahoo <satyajit.happy@gmail.com> 3.1.1
- moved repofile to another package
* Wed Nov 21 2012 Satyajit Sahoo <satyajit.happy@gmail.com> 2.3.0
- various updates
* Thu Jun 28 2012 Satyajit Sahoo <satyajit.happy@gmail.com> 2.1.1
- cleanup, removed repo from postinstall and added as a config file
* Sun Jan 22 2012 Satyajit Sahoo <satyajit.happy@gmail.com> 1.8.1
- policykit support
* Fri Nov 11 2011 Satyajit Sahoo <satyajit.happy@gmail.com> 1.7.6
- added license file
* Tue Oct 25 2011 Satyajit Sahoo <satyajit.happy@gmail.com> 1.7.3
- added postinstall script for adding the repo
* Thu Oct 06 2011 Satyajit Sahoo <satyajit.happy@gmail.com> 1.7.0
- rpm package built with the help of dangermouse
