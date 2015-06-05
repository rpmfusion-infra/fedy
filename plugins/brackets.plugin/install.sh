#!/bin/bash

dnf copr -y enable jgillich/brackets

dnf -y --releasever=21 install brackets
