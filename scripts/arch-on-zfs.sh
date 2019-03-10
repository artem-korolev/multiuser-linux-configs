#!/bin/bash

parted --script /dev/sdb mklabel gpt mkpart non-fs 0% 200M mkpart primary 200M 100% set 1 bios_grub on set 2 boot on
modprobe zfs
zpool create -f -o ashift=12 -m /zroot zroot /dev/disk/by-id/ata-VBOX_HARDDISK_VB09aeb64a-c95d6fd9
# create swap for target system
zfs create -V 64G -b $(getconf PAGESIZE) -o logbias=throughput -o sync=always -o primarycache=metadata -o com.sun:auto-snapshot=false zroot/archlinux-swap
zfs set atime=on zroot
zfs set relatime=on zroot
zfs create -o mountpoint=none -p zroot/sys/archlinux
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=none zroot/sys/archlinux/ROOT

# creating system datasets
# /
zfs create -o compression=lz4 -o mountpoint=/ zroot/sys/archlinux/ROOT/default
# /home
zfs create -o compression=lz4 -o mountpoint=/home zroot/sys/archlinux/home
# /usr
zfs create -o compression=lz4 -o mountpoint=/usr zroot/sys/archlinux/usr
# /usr/local
zfs create -o compression=lz4 -o mountpoint=/usr/local zroot/sys/archlinux/usr/local
# /opt
zfs create -o compression=lz4 -o mountpoint=/opt zroot/sys/archlinux/opt
# /var
zfs create -o compression=off -o xattr=sa -o mountpoint=/var zroot/sys/archlinux/var
# /var/log
zfs create -o compression=lz4 -o xattr=sa -o mountpoint=/var/log zroot/sys/archlinux/var/log
# /var/log/journal
zfs create -o compression=off -o xattr=sa -o acltype=posixacl -o mountpoint=/var/log/journal zroot/sys/archlinux/var/log/journal
# /var/cache
zfs create -o compression=lz4 -o xattr=sa -o mountpoint=/var/cache zroot/sys/archlinux/var/cache
# /var/lib
zfs create -o compression=lz4 -o xattr=sa -o mountpoint=/var/lib zroot/sys/archlinux/var/lib
# /var/lib/docker
zfs create -o compression=lz4 -o xattr=sa -o mountpoint=/var/lib/docker zroot/sys/archlinux/var/lib/docker
# /var/spool
zfs create -o compression=lz4 -o xattr=sa -o mountpoint=/var/spool zroot/sys/archlinux/var/spool
# /var/spool/mail
zfs create -o compression=lz4 -o xattr=sa -o mountpoint=/var/spool/mail zroot/sys/archlinux/var/spool/mail

zpool set bootfs=zroot/sys/archlinux/ROOT/default zroot
zpool export zroot
zpool import -d /dev/disk/by-id -R /mnt zroot

