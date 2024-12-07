git clone https://github.com/donaldzou/WGDashboard.git
cd ./WGDashboard/src
chmod +x ./wgd.sh
./wgd.sh install
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
sudo chmod 664 /etc/systemd/system/wg-dashboard.service
sudo systemctl daemon-reload
sudo systemctl enable wg-dashboard.service
sudo systemctl start wg-dashboard.service