#!/bin/bash

net_int=$(ip addr | awk '/state UP/ {print $2}' | cut -d':' -f 1)
sudo iptables-save > ~/iptables.rules.old
sudo ip tuntap add tap0 mode tap
sudo ip addr add 172.16.0.1/24 dev tap0
sudo ip link set tap0 up
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables -t nat -A POSTROUTING -o ${net_int} -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tap0 -o ${net_int} -j ACCEPT
