#!/bin/bash
# Fetch LoadBalancer IP from AKS
SERVICE_NAME=aks-app-service
NAMESPACE=default

IP=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "LB_IP=$IP"
