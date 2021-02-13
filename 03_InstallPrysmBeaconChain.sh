#!/bin/sh
wget -N https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh
chmod +x prysm.sh
./prysm.sh beacon-chain --download-only
sudo cp dist/beacon-chain-*-linux-amd64 /usr/local/bin/beacon-chain

sudo useradd --no-create-home --shell /bin/false prysmbeacon
sudo mkdir -p /var/lib/prysm/beacon
sudo chown -R prysmbeacon:prysmbeacon /var/lib/prysm/beacon
sudo chmod 700 /var/lib/prysm/beacon

sudo cp prysmbeacon.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start prysmbeacon
sudo systemctl enable prysmbeacon