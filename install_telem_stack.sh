#!/bin/bash
helm install prometheus -f ./metrics/prometheus-values.yaml stable/prometheus
helm install -f ./metrics/grafana-values.yaml grafana stable/grafana
