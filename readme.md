# Installing ETH2 Staker

Scripts tested for Ubuntu 20.04.
To install a staker on mainnet remove "--goerli" from "get.service" and "--pyrmont" from "prysmbeacon.service"

### Install first part
This setups the server, installs go-ethereum, prysm beacon-chain and prysm-validator

```
chmod +x *.sh
sudo ./01_SecureAndUpdateServer.sh <your_username>
sudo ./02_InstallGoEthereumNode.sh
sudo ./03_InstallPrysmBeaconChain.sh
sudo ./04_InstallPrysmValidator.sh
```

### Install second part

Now the validator keys need to be manually imported.
Copy the file "keystore-*.json" to "~/validator_keys"

```
sudo chown -R <your_username>:<your_username> /var/lib/prysm/validator
/usr/local/bin/validator accounts import --keys-dir=$HOME/validator_keys --wallet-dir=/var/lib/prysm/validator
echo "your_wallet_password" > /var/lib/prysm/validator/unicorn
```

After importing the keys, configure validator and install monitoring:

```
sudo ./05_ConfigurePrysmValidator.sh
sudo ./06_InstallMonitoring.sh
```

### Service check

```
sudo systemctl status prysmbeacon
sudo journalctl -fu prysmbeacon.service

sudo systemctl status prysmvalidator
sudo journalctl -fu prysmvalidator.service

sudo systemctl status prometheus
sudo systemctl status node_exporter
```

### Grafana
http://yourserverip:3000

https://docs.prylabs.network/assets/grafana-dashboards/small_amount_validators.json
