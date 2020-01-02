#!/bin/bash

# https://rpmfusion.org/Howto/CUDA

if [ -f /etc/yum.repos.d/cuda-fedora29.repo ] ; then
  rm -f /etc/yum.repos.d/cuda-fedora29.repo
fi

if [ -f /etc/yum.repos.d/cuda.repo ] ; then
  rm -f /etc/yum.repos.d/cuda.repo
fi

if [ -f /etc/yum.repos.d/fedora-cuda.repo ] ; then
  rm -f /etc/yum.repos.d/fedora-cuda.repo
fi

dnf remove -y cuda* 
