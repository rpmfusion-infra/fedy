#!/bin/bash

if [[ -d /boot/efi/EFI/fedora ]]; then
    grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
elif [[ -d /boot/grub2 ]]; then
    grub2-mkconfig -o /boot/grub2/grub.cfg
else
    exit 1
fi
