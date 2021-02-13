#!/bin/sh
wget -N https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh
chmod +x prysm.sh
./prysm.sh validator --download-only
sudo cp dist/validator-*-linux-amd64 /usr/local/bin/validator
sudo mkdir -p /var/lib/prysm/validator