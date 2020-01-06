#!/bin/bash

dnf copr enable abn/throttled -y
dnf install -y throttled

systemctl enable throttled
systemctl start throttled
