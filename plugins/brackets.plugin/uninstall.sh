#!/bin/bash

dnf copr -y disable jgillich/brackets
dnf -y --setopt clean_requirements_on_remove=1 erase brackets
