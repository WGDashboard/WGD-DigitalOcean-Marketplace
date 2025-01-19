#!/bin/sh

cd /root/WGDashboard/src
{ date; git pull; } >> ./log/update.txt

privateKey=$(wg genkey)

cat > /etc/wireguard/wg0.conf << EOL
[Interface]
PrivateKey = ${privateKey}
Address = 10.0.0.0/24
SaveConfig = true
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;
PreDown = 
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE;
ListenPort = 51820

EOL

systemctl enable wg-dashboard.service
systemctl start wg-dashboard.service
systemctl status wg-dashboard.service