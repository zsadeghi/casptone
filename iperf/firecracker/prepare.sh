#!/bin/bash

rm -rf exp
rm -rf mnt-server
rm -rf mnt-client
rm -rf vmlinux rootfs-client.ext4 rootfs-server.ext4
cp image/vmlinux .
cp image/rootfs-client.ext4 ./rootfs-client.ext4
cp image/rootfs-server.ext4 ./rootfs-server.ext4
