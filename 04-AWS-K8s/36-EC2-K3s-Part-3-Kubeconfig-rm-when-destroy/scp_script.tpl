scp -i ${private_key_path} \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/dev/null \
-q ubuntu@${nodeip}:/etc/rancher/k3s/k3s.yaml ${k3s_path}/k3s-${nodename}.yaml && 
sed -i 's/127.0.0.1/${nodeip}/' ${k3s_path}/k3s-${nodename}.yaml