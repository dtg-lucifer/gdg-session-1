#!/bin/bash
exec > /var/log/startup-script.log 2>&1
echo "Startup script execution started at $(date)"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
apt-get install -y make nginx
systemctl enable nginx
systemctl start nginx
echo "Startup script execution completed at $(date)"