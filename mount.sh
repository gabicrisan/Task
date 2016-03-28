#!/bin/bash  -x

if [ -f /root/control ]
then
   echo "disk already added"
   exit 0
fi

apt-get install -y parted
parted /dev/sdb mklabel msdos
parted /dev/sdb mkpart primary 0 100%
mkfs.xfs /dev/sdb1
mkdir /web
echo `blkid /dev/sdb1 | awk '{print$2}' | sed -e 's/"//g'` /web   xfs   noatime,nobarrier   0   0 >> /etc/fstab
mount /web

date > /root/control
