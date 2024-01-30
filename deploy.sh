#!/bin/bash
# A Script to automatically deploy the cloudflare-dns-sync.sh script into the system
# No Cronjobs are set by default

# Create directory for script
mkdir -p /opt/bin/cloudflare; 

# Downloading file
curl https://raw.githubusercontent.com/batscs/docker-cloudflare-dns-sync/main/cloudflare-dns-sync.sh > /opt/bin/cloudflare/cloudflare-dns-sync.sh

chmod +x /opt/bin/cloudflare/cloudflare-dns-sync.sh
