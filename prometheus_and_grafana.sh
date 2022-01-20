#!/bin/bash
echo "* installing prometheus and grafana into kubernetes cluster"
helm install prometheus prometheus-community/kube-prometheus-stack
 kubectl port-forward deploy/prometheus-grafana 3000

