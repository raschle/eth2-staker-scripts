#!/bin/sh
sudo useradd --no-create-home --shell /bin/false prysmvalidator
sudo chown -R prysmvalidator:prysmvalidator /var/lib/prysm/validator
sudo chmod 700 /var/lib/prysm/validator
sudo chmod -R 700 /var/lib/prysm/validator/unicorn

sudo cp prysmvalidator.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start prysmvalidator
sudo systemctl enable prysmvalidator