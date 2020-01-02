#!/bin/bash

# https://cloud.google.com/sdk/docs/quickstart-redhat-centos

if [ -f /etc/yum.repos.d/google-cloud-sdk.repo ] ; then
  rm -f /etc/yum.repos.d/google-cloud-sdk.repo
fi

# Remove the Cloud SDK
dnf remove -y google-cloud-sdk
