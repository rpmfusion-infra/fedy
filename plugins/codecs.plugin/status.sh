#!/bin/bash


rpm --quiet --query ffmpeg-libs || rpm --quiet --query  libavcodec-freeworld
