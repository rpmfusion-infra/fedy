#!/bin/bash

# https://rpmfusion.org/Howto/CUDA

# Deprecated repositories
if [ -f /etc/yum.repos.d/fedora-cuda.repo ] ; then
  rm -f /etc/yum.repos.d/fedora-cuda.repo
fi

 . /etc/os-release

cuda_arch=$(uname -m)

# Architectural tweaks
if [ ${cuda_arch} == aarch64 ] ; then
  cuda_arch=sbsa
fi

if [ ${cuda_arch} != x86_64 ] && [ ${ID} == fedora ] ; then
  # Lie on distro origin to install nvidia provided repository for el
  ID=el
  VERSION_ID=8
fi


# Older cuda repositories check removal
fedora_cuda_check_remove() {
  if [ -f /etc/yum.repos.d/cuda-fedora${1}.repo ] ; then
    rm -f /etc/yum.repos.d/cuda-fedora${1}.repo
  fi
}

rhel8_cuda_check_remove() {
  if [ -f /etc/yum.repos.d/cuda-rhel8.repo ] ; then
    rm -f /etc/yum.repos.d/cuda-rhel8.repo
  fi
}


# Distro/version install
fedora29_cuda_install() {
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora29/x86_64/cuda-fedora29.repo
  # prefer rpmfusion packaged driver on x86_64
  testexclude=$(fgrep -c "^exclude=" /etc/yum.repos.d/cuda-fedora29.repo)
  if [ ${testexclude} -eq 0 ] ; then
    echo "exclude=nvidia*,akmod-nvidia,kmod-nvidia*,dkms-nvidia" >> /etc/yum.repos.d/cuda-fedora29.repo 
  fi
}

fedora32_cuda_install() {
  fedora_cuda_check_remove 29
  rhel8_cuda_check_remove
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora32/x86_64/cuda-fedora32.repo
  # prefer rpmfusion packaged driver on x86_64
  dnf -y module disable nvidia-driver
}

fedora33_cuda_install() {
  fedora_cuda_check_remove 29
  fedora_cuda_check_remove 32
  rhel8_cuda_check_remove
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora33/${cuda_arch}/cuda-fedora33.repo
  # prefer rpmfusion packaged driver on x86_64
  dnf -y module disable nvidia-driver
}

fedora34_cuda_install() {
  fedora_cuda_check_remove 29
  fedora_cuda_check_remove 32
  fedora_cuda_check_remove 33
  rhel8_cuda_check_remove
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora34/${cuda_arch}/cuda-fedora34.repo
  # prefer rpmfusion packaged driver on x86_64
  dnf -y module disable nvidia-driver
}

fedora35_cuda_install() {
  fedora_cuda_check_remove 29
  fedora_cuda_check_remove 32
  fedora_cuda_check_remove 33
  fedora_cuda_check_remove 34
  rhel8_cuda_check_remove
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora35/${cuda_arch}/cuda-fedora35.repo
  # prefer rpmfusion packaged driver on x86_64
  dnf -y module disable nvidia-driver
}


el8_cuda_install() {
  fedora_cuda_check_remove 29
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel8/${cuda_arch}/cuda-rhel8.repo
  if [ ${cuda_arch} == x86_64 ] ; then
    # prefer rpmfusion packaged driver on x86_64
    dnf -y module disable nvidia-driver
  fi
}


# Distro install
fedora_cuda_install(){
  case ${VERSION_ID} in
    29|30|31) fedora29_cuda_install ;;
    32) fedora32_cuda_install ;;
    33) fedora33_cuda_install ;;
    34) fedora34_cuda_install ;;
    35|36|37) fedora35_cuda_install ;;
    *) exit 2 ;;
  esac
}

el_cuda_install() {
  case ${VERSION_ID} in
    9*) el8_cuda_install ;;
    8*) el8_cuda_install ;;
    *) exit 2 ;;
  esac
}

# Check Distro ID
case ${ID} in
  fedora) fedora_cuda_install ;;
  rhel|centos|el|almalinux|rocky) el_cuda_install ;;
  *) exit 2 ;;
esac


dnf install -y cuda
