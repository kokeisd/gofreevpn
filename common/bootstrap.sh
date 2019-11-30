export PATH=$PATH:/usr/bin
export AUTO_INSTALL=y
export MENU_OPTION=1
export CLIENT=vpnuser1
export PASS=1


#apt update && apt upgrade -y
mkdir -p /root/EasyRSA-v3.0.6
mkdir -p /etc/openvpn/easy-rsa
# apt-get install git -y
# sleep 3
# rm /var/lib/dpkg/lock
curl -o  /tmp/openvpn-install.sh https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
sudo chmod +x /tmp/openvpn-install.sh
ln -s  /root /home/root  ## dirty fix
# echo "*************** ${HOME} **************"
/tmp/openvpn-install.sh

#sudo sh -c "export PATH=$PATH:/usr/bin && export AUTO_INSTALL=y && export MENU_OPTION=1 && export CLIENT=user1 && export PASS=1 && ./openvpn-install.sh"