#!/bin/bash

wget "https://tonfotos.com/distribution/tonfotos/release/linux/tonfotos.repo"
mv "tonfotos.repo" "/etc/yum.repos.d/tonfotos.repo"
rpm --import https://tonfotos.com/distribution/public.key
dnf -y install tonfotos
