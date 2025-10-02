#!/bin/bash

# https://rpmfusion.org/Howto/CUDA


for i in 29 32 33 34 35 36 37 39 41 42 ; do
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

for i in 8 9 10 ; do
  if [ -f /etc/yum.repos.d/cuda-rhel${i}.repo ] ; then
    rm -f /etc/yum.repos.d/cuda-rhel${i}.repo
  fi
done

dnf remove -y cuda* 
