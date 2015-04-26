#!/bin/bash

run-as-root dnf -y install http://linuxdownload.adobe.com/adobe-release/adobe-release-$(uname -i)-1.0-1.noarch.rpm
run-as-root rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
run-as-root dnf -y install flash-plugin
