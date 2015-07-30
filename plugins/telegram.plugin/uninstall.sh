#!/bin/bash

dnf copr -y disable rommon/telegram

dnf -y --setopt clean_requirements_on_remove=1 erase telegram-desktop
