#!/bin/bash

rm -f vmlinux rootfs.ext4 
cp image/vmlinux .
cp image/rootfs.ext4 .
firecracker --no-api --config-file ./config.json
rm -f vmlinux
rm -rf mnt
mkdir mnt
sudo mount rootfs.ext4 mnt
rm -rf exp
mkdir exp
sudo cp -r mnt/experiment/* exp/
sudo chown -R zohreh:zohreh exp
sudo umount mnt 
sudo rm -rf mnt 
rm -rf rootfs.ext4 
