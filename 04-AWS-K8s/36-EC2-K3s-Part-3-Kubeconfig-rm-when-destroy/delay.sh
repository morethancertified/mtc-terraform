#!/bin/bash
while [ ! -f /etc/rancher/k3s/k3s.yaml ]; do
echo -e "Waiting for k3s to bootstrap..."
sleep 3
done