#!/bin/bash

set -e
set -x

MIRROR="https://mirror.one.com/archlinux/\$repo/os/\$arch"

if [ -e /dev/vda ]; then
  device=/dev/vda
elif [ -e /dev/sda ]; then
  device=/dev/sda
else
  echo "ERROR: There is no disk available for installation" >&2
  exit 1
fi
export device

sfdisk "$device" <<EOF
label: dos
type=83, bootable
EOF

mkfs.ext4 -L "rootfs" "${device}1"
mount "${device}1" /mnt

echo "Server = $MIRROR" > /etc/pacman.d/mirrorlist
pacstrap /mnt base grub openssh sudo polkit haveged
genfstab -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash
