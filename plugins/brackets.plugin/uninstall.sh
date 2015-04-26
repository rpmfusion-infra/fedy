#!/bin/bash

run-as-root dnf copr -y disable jgillich/brackets
run-as-root dnf -y --setopt clean_requirements_on_remove=1 erase brackets -y
