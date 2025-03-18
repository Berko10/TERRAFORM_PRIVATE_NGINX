#!/bin/bash
              sudo sed -i 's/\r//g' /var/lib/cloud/instance/user-data.txt
              # המרת תווי סיום מ-Windows ל-Linux
              apt-get update && apt-get install -y dos2unix
              sudo apt-get update
              sudo apt-get install iptables
              sudo iptables -F
              sudo iptables -t nat -F
              sudo iptables -Z
              sudo iptables -P INPUT ACCEPT
              sudo iptables -P FORWARD ACCEPT
              sudo iptables -P OUTPUT ACCEPT
              sudo sysctl -w net.ipv4.ip_forward=1
              sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
              sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination ${nginx_private_ip}:80
              sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT