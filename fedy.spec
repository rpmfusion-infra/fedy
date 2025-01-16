Name:           fedy
Version:        5.0.52
Release:        %autorelease
Summary:        Install codecs and additional software

License:        GPLv3+
URL:            https://github.com/rpmfusion-infra/fedy
Source0:        %{url}/archive/v%{version}/%{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  desktop-file-utils
BuildRequires:  libappstream-glib
BuildRequires:  make

%global obsolete_file L2V0Yy95dW0ucmVwb3MuZC91bml0ZWRycG1zLnJlcG8K

# Obsoletes introduced in f26
Provides: fedy-core = %{version}-%{release}
Obsoletes: fedy-core < 4.5.1-1
Provides: fedy-plugins = %{version}-%{release}
Obsoletes: fedy-plugins < 4.5.1-1
# Obsoletes introduced in f29
Obsoletes: fedy-release < 5.0.0-4
Provides: fedy-release = 5.0.0-4
# Obsoletes libva-intel-media-driver in f39+
Obsoletes: libva-intel-media-driver
Provides: libva-intel-media-driver

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
doesn't want to ship, like AAC,H264,H265 support, pre-built software, and
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
%autochangelog
