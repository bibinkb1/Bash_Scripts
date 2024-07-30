#!/bin/bash
sudo apt-get update
sudo apt install git -y
sudo apt install net-tools -y
sudo apt install python3 -y
sudo apt-get install vlc -y
sudo apt install vim -y
sudo apt install pidgin -y
sudo apt install filezilla -y 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm google-chrome-stable_current_amd64.deb
wget https://download.anydesk.com/linux/anydesk_6.3.2-1_amd64.deb
sudo apt install ./anydesk_6.3.2-1_amd64.deb -y
rm anydesk_6.3.2-1_amd64.deb
wget https://filestore.fortinet.com/forticlient/forticlient_vpn_7.0.7.0246_amd64.deb
sudo apt install ./forticlient_vpn_7.0.7.0246_amd64.deb -y
rm forticlient_vpn_7.0.7.0246_amd64.deb
wget https://az764295.vo.msecnd.net/stable/abd2f3db4bdb28f9e95536dfa84d8479f1eb312d/code_1.82.2-1694671812_amd64.deb
apt install ./code_1.82.2-1694671812_amd64.deb -y
rm code_1.82.2-1694671812_amd64.deb




