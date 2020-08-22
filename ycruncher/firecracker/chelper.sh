#!/bin/bash
# Courtesy of https://github.com/firecracker-microvm/firecracker/blob/master/docs/network-setup.md
iface=$1
if [[ -n "$(ip a | grep "tap${iface}")" ]];
then
  echo "A device named tap${iface} already exists. Deleting it now."
  sudo ip link del "tap${iface}"
fi
echo "Automatically setting up the host network for routing"
net_int=$(ip addr | awk '/state UP/ {print $2}' | cut -d':' -f 1)
echo "We think your active network interface is ${net_int}"
echo "If this is wrong, things could go bad. Press Ctrl+C now to abort."
echo "Waiting for 3 seconds ..."
sleep 3
sudo iptables-save > ~/iptables.rules.old
sudo ip tuntap add "tap${iface}" mode tap
sudo ip addr add "172.16.0.$((iface + 1))/24" dev "tap${iface}"
sudo ip link set "tap${iface}" up
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables -t nat -A POSTROUTING -o ${net_int} -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i "tap${iface}" -o ${net_int} -j ACCEPT
echo "Host setup for device tap${iface} at 172.16.0.$((iface + 1)) is done."
