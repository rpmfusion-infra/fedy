Name:           fedy
Version:        5.0.10
Release:        1%{?dist}
Summary:        Install codecs and additional software

License:        GPLv3+
URL:            https://github.com/rpmfusion-infra/fedy
Source0:        %{url}/archive/v%{version}/%{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  desktop-file-utils
BuildRequires:  libappstream-glib

%global obsolete_file L2V0Yy95dW0ucmVwb3MuZC91bml0ZWRycG1zLnJlcG8K

# Obsoletes introduced in f26
Provides: fedy-core = %{version}-%{release}
Obsoletes: fedy-core < 4.5.1-1
Provides: fedy-plugins = %{version}-%{release}
Obsoletes: fedy-plugins < 4.5.1-1
# Obsoletes introduced in f29
Obsoletes: fedy-release < 5.0.0-4
Provides: fedy-release = 5.0.0-4

Requires: dnf-plugins-core
Requires: hicolor-icon-theme
Requires: gjs
Requires: gtk3
Requires: libnotify
Requires: sed
Requires: tar
Requires: wget
Requires: jq


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
appstream-util validate-relax --nonet \
  %{buildroot}%{_datadir}/metainfo/%{name}.appdata.xml

%pre
obsolete=/tmp/no-exists
obsolete=$(echo %{obsolete_file} | base64 -d)
if [ -f ${obsolete} ] ; then
  rm -f ${obsolete} &>/dev/null
fi || :


%files
%license LICENSE
%doc CREDITS README.md
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/applications/*.%{name}.desktop
%{_datadir}/icons/hicolor/scalable/apps/%{name}.svg
%{_datadir}/icons/hicolor/scalable/apps/%{name}-symbolic.svg
%{_datadir}/polkit-1/actions/org.folkswithhats.pkexec.run-as-root.policy
%{_datadir}/metainfo/%{name}.appdata.xml


%changelog
* Wed Jun 24 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.10-1
- Update to 5.0.10

* Sun May 17 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.9-1
- Update to 5.0.9
- Add missing changelog - Nicolas Chauvet
- Mention EL8 support - Nicolas Chauvet
- Remove watchman (broken) - Nicolas Chauvet
- Remove ioscheduler plugin (outdated) - Nicolas Chauvet

* Sun May 17 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.8-1
- Update to 5.0.8
- chromium: fix condition - Nicolas Chauvet

* Sun May 17 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.7-1
- Update to 5.0.7
- Remove with -y - Nicolas Chauvet
- Add armhfp version - Nicolas Chauvet
- Add kernel longterm 5.4 - Nicolas Chauvet
- Add kernel-longterm-4.14 - Nicolas Chauvet
- Add kernel-longterm-4.19 - Nicolas Chauvet
- Add copr lantw44/arm-linux-gnueabi-toolchain - Nicolas Chauvet
- Add chromium-freeworld - Nicolas Chauvet

* Mon Feb 03 2020 Malte Kiefer <malte.kiefer@mailgermania.de> - 5.0.6-2
- Update to 5.0.6-2

* Mon Feb 03 2020 Malte Kiefer <malte.kiefer@mailgermania.de> - 5.0.6-1
- Update to 5.0.6-1

* Mon Feb 03 2020 Malte Kiefer <malte.kiefer@mailgermania.de> - 5.0.6
- added alacritty - Malte Kiefer
- added waybar - Malte Kiefer
- fix anydesk installation and uninstallation - Malte Kiefer
- added MongoDB - Malte Kiefer
- Fixup pulseaudio category - Nicolas Chauvet

* Mon Jan 20 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.5.2-1
- Update to 5.0.5.2

* Mon Jan 20 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.5.1-1
- Update to 5.0.5.1

* Mon Jan 06 2020 Malte Kiefer <malte.kiefer@mailbox.org> - 5.0.4-1
- Merge pull request #32 from MalteKiefer/azurecli - Malte Kiefer
- Merge pull request #33 from MalteKiefer/msteams - Malte Kiefer
- Merge pull request #37 from MalteKiefer/throttled - Malte Kiefer
- change category - Malte Kiefer
- change to Proprietary - Malte Kiefer
- added throttled - Malte Kiefer
- Remove old hangout plugin - Nicolas Chauvet
- Update google-talkplugin as hangout - Nicolas Chauvet
- [HACK] scale down Cloud_SDK.svg until it can be fixed properly - Nicolas Chauvet
- [HACK] scale down brave_lion.svg until it can be displayed properly - Nicolas Chauvet
- Quiet onlyoffice-desktopeditors status - Nicolas Chauvet
- Quiet gitkraken status - Nicolas Chauvet
- added Azure CLI - Malte Kiefer
- better uninstall script - Malte Kiefer
- added Microsoft Teams - Malte Kiefer
- Merge pull request #27 from MalteKiefer/watchman - Nicolas Chauvet (kwizart)
- Create metadata.json - Malte Kiefer
- Create install.sh - Malte Kiefer
- Merge pull request #25 from MalteKiefer/onedrive - Nicolas Chauvet (kwizart)
- Create metadata.json - Malte Kiefer
- Create install.sh - Malte Kiefer

* Thu Jan 02 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.3-1
- Add google-webdesigner
- Add bluejeans-v2
- Add google talk plugin
- Add google earth pro
- Rename chrome -> google-chrome
- rename cuda -> nvidia-cuda
- Add nouveau-firmware / dvb-firmware
- Add b43-firmware
- Add broadcom-bt plugin
- Add broadcom-wl
- Add google-cloud-sdk
- Refresh brave
- Remove popcorntime
- Update description and order

* Wed Jan 01 2020 Nicolas Chauvet <kwizart@gmail.com> - 5.0.2-1
- Switch jre install with rpm -Uvh
- Fixup mp3/h264
- Fix dino - now in fedora
- Fix spotify reported by https://github.com/MalteKiefer
- pull request #24 from MalteKiefer/neomutt
- Add nvidia machine learning repo
- Add nvidia-gpu-driver-390xx
- Add nvidia-gpu-driver
- Add cuda plugin
- pull request #21 from MalteKiefer/docker_ce
- pull request #20 from MalteKiefer/anydesk_add
- pull request #17 from MalteKiefer/slack_fix

* Tue Dec 10 2019 Nicolas Chauvet <kwizart@gmail.com> - 5.0.1-1
- Update to 5.0.1

* Thu Aug 22 2019 Nicolas Chauvet <kwizart@gmail.com> - 5.0.0-1
- Update to 5.0.0
* Wed Aug 21 2019 Nicolas Chauvet <kwizart@gmail.com> - 4.8.0-2
- Obsoletes fedy-release
- Drop rpmfusion-release requires
- Fix upstream URL for appdata
- Add --nonet for metainfo
* Wed May 29 2019 Benjamin Denhartog <ben@sudoforge.com> - 4.8.0-1
- ea67502 ben@sudoforge.com bump: v4.8.0
- 3e81360 danielandrewstewart@gmail.com add instructions for building from source
- 1b99cf8 danielandrewstewart@gmail.com resize icons: dino, slack
- af9c655 3893293+sudoforge@users.noreply.github.com add initial issue templates
- 911a9de as.maps@gmail.com Update postman icon path
- de792a6 eprudhomme@gmail.com Fix Gjs-WARNING on Uint8Array
- 80072ab eprudhomme@gmail.com Refactor options to more meaningful names
- 0e8741c eprudhomme@gmail.com Remove unnecessary double quote in reports
- 6322e0f eprudhomme@gmail.com Update cli to customize option_context only if available
- a37739b eprudhomme@gmail.com Remove unnecessary comments
- 517985f eprudhomme@gmail.com Update Application class to register CLI options via FedyCli
- b80de2f eprudhomme@gmail.com Add FedyCli class implementing CLI functionnality for fedy
- 656aa88 eprudhomme@gmail.com Add PluginRepository class to wrap interactions with fedy plugins
- e933b2b eprudhomme@gmail.com Add Option class for CLI behaviour
- c096077 eprudhomme@gmail.com Remove duplicated 'no-octal-escape' eslint rule
- 923468d danielandrewstewart@gmail.com Use RPM instead of DNF
- 7ec0f31 ben@sudoforge.com bump to version 4.7
- 0d2a30c ben@sudoforge.com minor readme changes
- 6c3e8b0 danielandrewstewart@gmail.com Fix Simplenote install
- 6b9f21a danielandrewstewart@gmail.com Fix URL
- 753f099 3893293+sudoforge@users.noreply.github.com remove configuration for the 'stale' github application (#630)
- f2e4fdb gaurav.rawal66@gmail.com rename COPYING to LICENSE (#627)
- 25f6752 3893293+sudoforge@users.noreply.github.com add 'jq' as a dependency (#624)
- 7d09ba2 eprudhomme@gmail.com Add Moka icon theme (#620)
- 8e8e3ea ben@sudoforge.com remove libre property from all metadata files
- 448fadb dman@EmmasLaptop.localdomain Add Mixx DJ Software plugin
- 24cf33f dman@EmmasLaptop.localdomain Added Zoom plugin
- f7dfb8c dman@EmmasLaptop.localdomain Adding Lutris plugin
- 7a84140 dman@EmmasLaptop.localdomain Added Slack plugin
- 1b40379 32564392+dmanlfc@users.noreply.github.com Adding the Flat-Remix theme (#613)
- 2f28635 Malte Kiefer rename plugins/dino.plugin{=>s}
- c47351c malte.kiefer@mailgermania.de add plugin 'quilter'
- 36421c3 ben@sudoforge.com only set the license text display if a license property exists
- b7e2314 ben@sudoforge.com display when a plugin is being loaded into the view
- 47d1298 ben@sudoforge.com remove plugin 'brackets'
- e417d87 ben@sudoforge.com update specfile to match currently deployed version of fedy
- 640713e malte.kiefer@mailgermania.de add plugin signal-desktop
- ab93ab1 ben@sudoforge.com add initial conffile for the 'stale' application
- 3f1eac9 arvindhn602@outlook.com Android studio Icon Update
- b0a5e39 Xmetalfanx@yahoo.com Download Google signing key needed for Hangouts
- 5e82bbf danielandrewstewart@gmail.com Add plexmediaplayer Closes #433
- 89e879f alistair@agchapman.com Add Postman plugin
- b66ca3f danielandrewstewart@gmail.com Add OnlyOffice plugin
- af1d348 nhubbard@users.noreply.github.com Update label attribute for Sublime Text 2
- 14cc847 pr3ach3r@dismail.de Add files via upload
- 321e5f1 pr3ach3r@dismail.de Create metadata.json
- f97efa8 pr3ach3r@dismail.de Create install.sh
- 6306e88 adil452100@yahoo.fr Fix missing shared library libXss.so.1 on startup
- 230bfc5 nhubbard@users.noreply.github.com Updated Beta Status for Sublime Text 3
- 83ebd06 nhubbard@users.noreply.github.com Update metadata.json
- ba8b180 magnunleno@users.noreply.github.com Make parent directory
- b9968f3 danielandrewstewart@gmail.com Add adapta theme
- b18495a luca.dimaio1@gmail.com Fix MasterPdfEditor Install
* Sun Apr 22 2018 Benjamin Denhartog <ben@sudoforge.com> - 4.6.0-1
- update author information for Benjamin Denhartog
- repackage fedy with updated specfile
* Wed Apr 18 2018 Benjamin Denhartog <ben@sudoforge.com> - 4.6.0-0
- (6e2ec1e) ben@sudoforge.com re-add opera's fedy icon to the repository with LFS
- (affdf71) ben@sudoforge.com remove opera's fedy icon from the git repository
- (304e258) Malte Kiefer Added Papirus
- (95ece48) danielandrewstewart@gmail.com Add firefox developer edition
- (a467ca1) arvindhn602@outlook.com Fix Missing URL
- (ecc5ad4) luca.dimaio1@gmail.com [WIP] Expand Software Offering: Opera
- (98637ed) AbhinavOther@gmail.com Fixes requested in review
- (7f32321) AbhinavOther@gmail.com Fixes Install of Sublime Text 3
- (595df95) AbhinavOther@gmail.com #482 - Install Brave broswer
- (acbd8e1) as.maps@gmail.com Simplify description for VirtualBox
* Fri Aug 25 2017 Benjamin Denhartog <ben@sudoforge.com> 4.5.2-0
- (3fede16) kwizart@gmail.com Add fedy spec into the fedy repo
- (d681cc4) kwizart@gmail.com Improve comment (use verb) and remove desktop-validate
- (4b2c3ad) kwizart@gmail.com Fix screenshot width and height for appdata-validate
- (9688eab) ben@sudoforge.com re-add binary files to the index with git-lfs
- (f682c2a) ben@sudoforge.com remove existing binary files from the index
* Tue Aug 01 2017 Nicolas Chauvet <kwizart@gmail.com> - 4.5.1-1
- Update to 4.5.1
* Thu Jul 27 2017 Benjamin Denhartog <ben@sudoforge.com> 4.5.1
- (d38f68d) devinshoe@gmail.com Install libXScrnSaver with GitKraken
* Mon Jul 24 2017 Nicolas Chauvet <kwizart@gmail.com> - 4.5.0-1
- Spec file clean-up
- Obsoletes fedy-plugins and fedy-gui
* Mon Jul 24 2017 Benjamin Denhartog <ben@sudoforge.com> 4.5.0
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
- (7d2c5c8) ben@sudoforge.com refactor the logging done in the plugin for skype
* Mon Jul 17 2017 Benjamin Denhartog <ben@sudoforge.com> 4.4.1
- (cfe64c9) ben@sudoforge.com add swapfiles to git ignore
- (0cb09c6) ben@sudoforge.com refactor skype plugin
* Sun Jul 16 2017 Benjamin Denhartog <ben@sudoforge.com> 4.4.0
- (ce0b7e8) ben@sudoforge.com refactor label for resilio sync
- (574914a) ben@sudoforge.com refactor label and description for google play music desktop player
- (f81a195) ben@sudoforge.com remove cerebro from plugins
- (971c5aa) ben@sudoforge.com fix invalid status check for yatta plugin
- (b8877b1) ben@sudoforge.com fix typo in 'quiet' option for rpm
- (0fe8f8a) ben@sudoforge.com apply changes requested in review
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
* Sat Jun 10 2017 Benjamin Denhartog <ben@sudoforge.com> 4.3.6
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
