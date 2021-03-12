#!/bin/bash

# https://rpmfusion.org/Howto/CUDA

if [ -f /etc/yum.repos.d/cuda-fedora29.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-fedora29.repo
fi

if [ -f /etc/yum.repos.d/cuda-fedora32.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-fedora32.repo
fi

if [ -f /etc/yum.repos.d/cuda-fedora33.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-fedora33.repo
fi

if [ -f /etc/yum.repos.d/cuda.repo ] ; then
  rm -f /etc/yum.repos.d/cuda.repo
fi

if [ -f /etc/yum.repos.d/fedora-cuda.repo ] ; then
  rm -f /etc/yum.repos.d/fedora-cuda.repo
fi

if [ -f /etc/yum.repos.d/cuda-rhel8.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-rhel8.repo
fi

dnf remove -y cuda* 
