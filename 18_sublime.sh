#!/usr/bin/bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -  
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install sublime-text -y