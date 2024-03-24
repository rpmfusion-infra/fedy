#!/bin/bash

curl -1sLf -o /tmp/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
rpm --import /tmp/teams-for-linux.asc
rm -f /tmp/teams-for-linux.asc

cat > /etc/yum.repos.d/teams-for-linux.repo << "EOF" 
[teams-for-linux]
name=Repo for the unofficial Teams for Linux package
baseurl=https://repo.teamsforlinux.de/rpm/
enabled=1
gpgcheck=1
EOF

dnf install teams-for-linux -y
