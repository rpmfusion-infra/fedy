#!/bin/bash

cat <<EOF > /etc/yum.repos.d/mongodb.repo
[Mongodb]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOF

dnf -y install mongodb-org
systemctl enable mongod.service
systemctl start mongod.service