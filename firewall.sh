iptables -F

# I.
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# II.
iptables -P INPUT DROP
iptables -P FORWARD DROP
