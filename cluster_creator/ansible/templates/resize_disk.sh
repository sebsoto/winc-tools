#!/bin/sh

# increase home directory size
umount /dev/sdb1
pvcreate /dev/sdb1 -y
vgextend rootvg /dev/sdb1 
lvm lvextend -l +100%FREE /dev/mapper/rootvg-homelv
resize2fs -p /dev/mapper/rootvg-homelv
