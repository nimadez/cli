### Basic firewall using iptables

This is a very simple example, which allows control of the internal LAN network, as well as allowing access to the Internet with minimal restrictions.

> - This does not work on DHCP-based network configurations.
> - It also sets the ```no-internet``` group to use [net-block](https://github.com/nimadez/cli/blob/main/net-block.sh) and [net-block-gui](https://github.com/nimadez/cli/blob/main/net-block-gui.sh) scripts.
> - To configure IPv6 you need to use ```ip6tables```.
> - For added security, you can only allow access to HTTP, HTTPS, FTP, SSH, DNS resolver and NTP (time synchronization) ports from TCP/UDP, but this is not possible in some situations and is best suited for servers with maximum security and minimal features.

```
sudo addgroup no-internet

# Flush rules
sudo iptables -F && sudo iptables -X
sudo iptables -t nat -F && sudo iptables -t nat -X
sudo iptables -t mangle -F && sudo iptables -t mangle -X

# Set default policies
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP

# Block specific groups (completely blocked)
sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP

# Allow all traffic on loopback interface
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Allow established and related connections
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow outgoing ICMP for ping or MTU discovery
sudo iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT

# Allow outgoing TCP and UDP ports from the local server
sudo iptables -A OUTPUT -p tcp -s 192.168.x.xxx -j ACCEPT
sudo iptables -A OUTPUT -p udp -s 192.168.x.xxx -j ACCEPT

# Allow incoming whitelisted LAN addresses (specific ports only)
sudo iptables -A INPUT -p tcp -m multiport --dports xxxx,xxxx -s 192.168.x.xxx -j ACCEPT
sudo iptables -A INPUT -p tcp -m multiport --dports xxxx,xxxx -s 192.168.x.xxx -j ACCEPT
sudo iptables -A INPUT -p tcp -m multiport --dports xxxx,xxxx -s 192.168.x.xxx -j ACCEPT
```
