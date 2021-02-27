#!/bin/bash
sudo hostnamectl set-hostname mtc-${nodename} &&
curl -sfL https://get.k3s.io | sh -s - server \
--datastore-endpoint="mysql://${dbuser}:${dbpass}@tcp(${db_endpoint})/${dbname}" \
--write-kubeconfig-mode 644