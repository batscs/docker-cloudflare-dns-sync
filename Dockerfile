# Base Image
FROM ubuntu:22.04

MAINTAINER dev@bats.li

# Installing requirements
RUN apt-get update

# nano for editing the script file for cloudflare api connection
RUN apt-get install -y nano

# curl to download the script
RUN apt-get install -y curl

# cron to schedule the script
RUN apt-get install -y cron

# jq to work with json
RUN apt-get install -y jq

# host to get information about the ip of a domain
# prevent useless cloudflare api calls, if domain already has the ip
RUN apt-get install -y host

# Create directory for script
RUN mkdir -p /opt/bin/cloudflare; 

# Downloading file into directory
RUN curl https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/cloudflare-dns-sync.sh > /opt/bin/cloudflare/cloudflare-dns-sync.sh

# Ensure execution permissions for the script file
RUN chmod +x /opt/bin/cloudflare/cloudflare-dns-sync.sh

# Run cron in foreground on each container start
# If not in foreground (-f), container will exit after finishing the command
CMD cron -f
