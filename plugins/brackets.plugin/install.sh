#!/bin/bash

run-as-root dnf -y install dnf-plugins-core
run-as-root dnf copr -y enable jgillich/brackets
run-as-root dnf -y install brackets
