#!/bin/bash

echo "Downloading Grafana dashboards..."

mkdir -p /etc/grafana/provisioning/dashboards/json

curl -L https://grafana.com/api/dashboards/1860/revisions/23/download \
  -o /etc/grafana/provisioning/dashboards/json/node-exporter.json

curl -L https://grafana.com/api/dashboards/3662/revisions/2/download \
  -o /etc/grafana/provisioning/dashboards/json/prometheus-stats.json

echo "Dashboards downloaded."

# Start Grafana
/run.sh

