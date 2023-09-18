#!/bin/bash

# https://rpmfusion.org/Howto/CUDA


for i in 29 32 33 34 35 36 37 ; do
  if [ -f /etc/yum.repos.d/cuda-fedora${i}.repo ] ; then
    rm -f /etc/yum.repos.d/cuda-fedora${i}.repo
  fi
done

if [ -f /etc/yum.repos.d/cuda.repo ] ; then
  rm -f /etc/yum.repos.d/cuda.repo
fi

if [ -f /etc/yum.repos.d/fedora-cuda.repo ] ; then
  rm -f /etc/yum.repos.d/fedora-cuda.repo
fi

if [ -f /etc/yum.repos.d/cuda-rhel8.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-rhel8.repo
fi

if [ -f /etc/yum.repos.d/cuda-rhel9.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-rhel9.repo
fi

dnf remove -y cuda* 
