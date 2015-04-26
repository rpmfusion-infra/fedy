#!/bin/bash

if [[ -d /boot/grub2 ]]; then
    run-as-root grub2-mkconfig -o /boot/grub2/grub.cfg
elif [[ -d /boot/efi/EFI/fedora ]]; then
    run-as-root grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
else
    exit 1
fi
