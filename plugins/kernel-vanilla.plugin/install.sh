#!/bin/bash

cat <<EOF > /etc/yum.repos.d/fedora-kernel-vanilla-stable.repo
[fedora-kernel-vanilla-stable]
name=Linux vanilla kernels for Fedora, stable series
baseurl=http://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-$releasever/$basearch/
enabled=1
skip_if_unavailable=1
gpgcheck=1
gpgkey=http://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/RPM-GPG-KEY-fedora-kernel-vanilla

[fedora-kernel-vanilla-stable-source]
name=Linux vanilla kernels for Fedora, stable series - Source
baseurl=http://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-$releasever/SRPMS
enabled=0
skip_if_unavailable=1
gpgcheck=1
gpgkey=http://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/RPM-GPG-KEY-fedora-kernel-vanilla
EOF

dnf -y update kernel
