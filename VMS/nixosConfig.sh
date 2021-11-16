#!/bin/bash
#https://nixos.org/manual/nixos/stable/index.html#sec-installation

#uefi(GPT)
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart primary 512MiB -8GiB
parted /dev/vda -- mkpart primary linux-swap -4GiB 100%
parted /dev/vda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/vda -- set 3 esp on
# Formatting
mkfs.ext4 -L nixos /dev/vda1
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda3
#Installing
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/vda2
#TODO: import and replace from github
nixos-generate-config --root /mnt
vi /mnt/etc/nixos/configuration.nix
nixos-install
