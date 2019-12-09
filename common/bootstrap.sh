export PATH=$PATH:/usr/bin
export AUTO_INSTALL=y
export MENU_OPTION=1
export CLIENT=$1
export PASS=1

mkdir -p /root/EasyRSA-v3.0.6
mkdir -p /etc/openvpn/easy-rsa
curl -o  /tmp/openvpn-install.sh https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
sudo chmod +x /tmp/openvpn-install.sh
ln -s  /root /home/root  ## dirty fix
/tmp/openvpn-install.sh