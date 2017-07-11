#!/bin/bash

dnf -y --setopt clean_requirements_on_remove=1 remove flash-plugin adobe-release
