#!/bin/bash

echo "partitioning"
parted --script /dev/sdb mklabel gpt mkpart primary 0% 200M mkpart primary 200M 100% set 1 boot on set 1 esp on
partprobe
echo "format esp (efi boot) partition to fat32"
mkfs.fat -F32 /dev/sdb1
modprobe zfs
echo "create zpool"
zpool create -f -o ashift=12 -m /zroot zroot /dev/disk/by-id/ata-VBOX_HARDDISK_VB09aeb64a-c95d6fd9-part2
# create swap for target system
echo "creating swap"
zfs create -V 64G -b $(getconf PAGESIZE) -o logbias=throughput -o sync=always -o primarycache=metadata -o com.sun:auto-snapshot=false zroot/archlinux-swap

echo "creating sys/data datasets"
# create sys and data datasets
zfs set atime=on zroot
zfs set relatime=on zroot
zfs create -o mountpoint=none -p zroot/sys/archlinux
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=none zroot/sys/archlinux/ROOT

echo "creating arch linux system datasets"
# creating system datasets
# /
zfs create -o compression=lz4 -o mountpoint=/ zroot/sys/archlinux/ROOT/default
# /boot
zfs create -o compression=off -o mountpoint=/boot zroot/sys/archlinux/boot
# /etc
zfs create -o compression=gzip-9 -o mountpoint=/etc zroot/data/etc
# /home
zfs create -o compression=lz4 -o mountpoint=/home zroot/sys/archlinux/home
# /repos
zfs create -o compression=gzip-9 -o mountpoint=/repos zroot/data/repos
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

echo "mark boot dataset"
zpool set bootfs=zroot/sys/archlinux/ROOT/default zroot
#echo "export zroot"
#zpool export zroot
cd /tmp
wget https://mirror.fi.armbrust.me/archlinux/iso/2019.03.01/archlinux-bootstrap-2019.03.01-x86_64.tar.gz
tar xzf archlinux-bootstrap-2019.03.01-x86_64.tar.gz
/tmp/root.x86_64/bin/arch-chroot /tmp/root.x86_64/
#echo "import zroot"
#zpool import -d /dev/disk/by-id -R /mnt zroot
echo "Run: zpool export zroot"
echo "Run: zpool import -d /dev/disk/by-id -R /mnt zroot"
echo "Run: zpool set cachefile=/etc/zfs/zpool.cache zroot"
echo "Run: mkdir -p /mnt/etc/zfs/"
echo "Run: cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache"
echo "Run: mkdir /mnt/efi"
echo "Run: mount /dev/sdb1 /mnt/efi"
echo "Run: genfstab -U -p /mnt >> /mnt/etc/fstab"
#zpool set cachefile=/etc/zfs/zpool.cache zroot
#mkdir -p /mnt/etc/zfs/
#cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache
#mkdir /mnt/efi
#mount /dev/sdb1 /mnt/efi
#genfstab -U -p /mnt >> /mnt/etc/fstab
