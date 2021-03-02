#!/bin/sh
rm dist/*
wget -N https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh
chmod +x prysm.sh
./prysm.sh beacon-chain --download-only
./prysm.sh validator --download-only

sudo systemctl stop prysmvalidator
sudo systemctl stop prysmbeacon
sudo cp dist/beacon-chain-*-linux-amd64 /usr/local/bin/beacon-chain
sudo cp dist/validator-*-linux-amd64 /usr/local/bin/validator
sudo systemctl start prysmbeacon
sudo systemctl start prysmvalidator
