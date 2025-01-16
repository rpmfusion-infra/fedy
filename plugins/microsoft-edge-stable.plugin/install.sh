#!/bin/bash

 . /etc/os-release

rpm --import https://packages.microsoft.com/keys/microsoft.asc


dnf4_repo_install() {
  dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
}

dnf5_repo_install() {
  dnf config-manager addrepo --from-repofile=https://packages.microsoft.com/yumrepos/edge/config.repo --save-filename=microsoft-edge-stable --overwrite
}

dnf_repo_install(){
  case ${VERSION_ID} in
    40) dnf4_repo_install ;;
    4*) dnf5_repo_install;;
    5*) dnf5_repo_install;;
    *) dnf4_repo_install ;;
  esac
}

dnf_repo_install
dnf install microsoft-edge-stable -y
