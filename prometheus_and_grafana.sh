#!/bin/bash
echo "* installing prometheus and grafana into kubernetes cluster"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack
kubectl port-forward deploy/prometheus-grafana 3000

