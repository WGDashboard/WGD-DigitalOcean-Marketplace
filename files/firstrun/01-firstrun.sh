cd /root/WGDashboard/src
{ date; git pull; } >> ./log/update.txt

privateKey=$(wg genkey)

cat > /etc/wireguard/wg0.conf << EOL
[Interface]
PrivateKey = ${privateKey}
SaveConfig = true
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;
PreDown = 
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE;
ListenPort = 51820

EOL

sudo systemctl start wg-dashboard.service
sudo systemctl status wg-dashboard.service