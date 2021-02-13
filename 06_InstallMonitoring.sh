#!/bin/sh
sudo useradd --no-create-home --shell /bin/false prometheus
sudo useradd --no-create-home --shell /bin/false node_exporter

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus

wget -N https://github.com/prometheus/prometheus/releases/download/v2.24.1/prometheus-2.24.1.linux-amd64.tar.gz
wget -N https://github.com/prometheus/node_exporter/releases/download/v1.1.0/node_exporter-1.1.0.linux-amd64.tar.gz
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt update
apt-cache policy grafana
sudo apt install -y grafana

tar xvf prometheus-*.linux-amd64.tar.gz
tar xvf node_exporter-*.linux-amd64.tar.gz

sudo cp prometheus-*.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-*.linux-amd64/promtool /usr/local/bin/
sudo cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin

sudo chown -R prometheus:prometheus /usr/local/bin/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/promtool
sudo chown -R node_exporter:node_exporter /usr/local/bin/node_exporter

sudo cp -r prometheus-*.linux-amd64/consoles /etc/prometheus
sudo cp -r prometheus-*.linux-amd64/console_libraries /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

rm -rf prometheus-*.linux-amd64.tar.gz prometheus-*.linux-amd64
rm -rf node_exporter-*.linux-amd64.tar.gz node_exporter-*.linux-amd64

sudo cp prometheus.yml /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus/prometheus.yml

sudo cp prometheus.service /etc/systemd/system/
sudo cp node_exporter.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl start node_exporter
sudo systemctl start grafana-server
sudo systemctl enable prometheus
sudo systemctl enable node_exporter
sudo systemctl enable grafana-server



