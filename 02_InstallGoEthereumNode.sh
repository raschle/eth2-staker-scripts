#!/bin/sh
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update -y
sudo apt install -y geth

sudo useradd --no-create-home --shell /bin/false goeth
sudo mkdir -p /var/lib/goethereum
sudo chown -R goeth:goeth /var/lib/goethereum
sudo cp geth.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start geth
sudo systemctl enable geth