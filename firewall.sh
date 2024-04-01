#!/bin/bash

iptables -F

# I.
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# II.
iptables -P INPUT DROP
iptables -P FORWARD DROP

# III.
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth2 -s 10.1.1.0/24 -j MASQUERADE

iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 443 -j ACCEPT

# IV.
iptables -A FORWARD -m string --string "games" --algo kmp -j LOG --log-prefix "Blocked: "
iptables -A FORWARD -m string --string "games" --algo kmp -j DROP
