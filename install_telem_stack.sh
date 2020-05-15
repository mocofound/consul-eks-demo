#!/bin/bash
#helm uninstall prometheus
#helm uninstall grafana
helm install prometheus -f ./metrics/prometheus-values.yaml stable/prometheus
helm install -f ./metrics/grafana-values.yaml grafana stable/grafana
#helm install grafana -f ./metrics/grafana-values.yaml grafana stable/grafana
