#!/bin/bash
# A Script to automatically deploy the cloudflare-dns-sync.sh script into the system
# No Cronjobs are set by default

# Create directory for script
mkdir -p ~/.cloudflare; 

# Downloading file
curl https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/cloudflare-dns-sync.sh > ~/.cloudflare/cloudflare-dns-sync.sh
