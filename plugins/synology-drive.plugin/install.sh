#!/bin/bash

dnf copr -y enable emixampp/synology-drive 

dnf --refresh install synology-drive
