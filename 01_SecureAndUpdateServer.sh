#!/bin/sh
if [ -z "$1" ]
  then
    echo "Supply a username"
    exit 1
fi

adduser $1
usermod -aG sudo $1
sudo apt update -y && sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt autoremove -y
sudo apt-get install software-properties-common

sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "adding ssh 22/tcp to ufw"
sudo ufw allow 22/tcp

echo "adding go-ethereum node 30303/udp/tcp to ufw"
sudo ufw allow 30303

echo "adding prysm beacon p2p 13000/tcp to ufw"
sudo ufw allow 13000/tcp

echo "adding prysm beacon p2p 13000/udp to ufw"
sudo ufw allow 12000/udp

echo "adding grafana 3000/tcp to ufw"
sudo ufw allow 3000/tcp
sudo ufw --force enable

sudo apt-get remove -y ntp
sudo timedatectl set-ntp on
