# Base Image
FROM ubuntu:22.04

MAINTAINER dev@bats.li

# Installing requirements
RUN apt-get update
RUN apt-get install -y nano
RUN apt-get install -y curl
RUN apt-get install -y cron
RUN apt-get install -y jq
RUN apt-get install -y host

# Create directory for script
RUN mkdir -p ~/.cloudflare; 

# Downloading file into directory
RUN curl https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/cloudflare-dns-sync.sh > ~/.cloudflare/cloudflare-dns-sync.sh

RUN chmod +x ~/.cloudflare/cloudflare-dns-sync.sh
