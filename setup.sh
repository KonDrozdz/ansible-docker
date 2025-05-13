#!/bin/bash

echo "[INFO] Generating SSH key (if not exists)..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
fi

echo "[INFO] Waiting for SSH on node1 and node2..."
for node in node1 node2; do
  until sshpass -p "root" ssh -o StrictHostKeyChecking=no root@$node "echo $node SSH is ready"; do
    sleep 2
  done
done

echo "[INFO] Copying SSH key to target nodes..."
for node in node1 node2; do
  sshpass -p "root" ssh-copy-id -o StrictHostKeyChecking=no root@$node
done

echo "[INFO] Testing Ansible ping..."
ansible all -m ping

echo "[INFO] Running Ansible playbook..."
ansible-playbook /playbooks/deploy_web.yml

echo "[INFO] Setup complete. Container is now idle."
tail -f /dev/null
