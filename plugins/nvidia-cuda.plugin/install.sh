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
fi


# Older cuda repositories check removal
fedora29_cuda_check_remove() {
  if [ -f /etc/yum.repos.d/cuda-fedora29.repo ] ; then
    rm -f /etc/yum.repos.d/cuda-fedora29.repo
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
  fedora29_cuda_check_remove
  rhel8_cuda_check_remove
  dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora32/x86_64/cuda-fedora32.repo
  # prefer rpmfusion packaged driver on x86_64
  dnf -y module disable nvidia-driver
}

el8_cuda_install() {
  fedora29_cuda_check_remove
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
    32|33) fedora32_cuda_install ;;
    *) exit 2 ;;
  esac
}

el_cuda_install() {
  case ${VERSION_ID} in
    8*) el8_cuda_install ;;
    *) exit 2 ;;
  esac
}

# Check Distro ID
case ${ID} in
  fedora) fedora_cuda_install ;;
  rhel|centos|el) el_cuda_install ;;
  *) exit 2 ;;
esac


dnf install -y cuda
