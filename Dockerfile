# Base Image
FROM ubuntu:22.04

MAINTAINER dev@bats.li

# Installing requirements
RUN apt-get update --fix-missing

# nano for editing the script file for cloudflare api records
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
RUN mkdir -p /app; 

# Create directory for cron script
RUN mkdir -p /app/data

# Downloading file into directory
RUN curl https://raw.githubusercontent.com/batscs/docker-cloudflare-dns-sync/main/cloudflare-dns-sync.sh > /app/cloudflare-dns-sync.sh

RUN curl https://raw.githubusercontent.com/batscs/docker-cloudflare-dns-sync/main/app/init.sh -o /app/init.sh

# Ensure execution permissions for the script file
RUN chmod +x /app/cloudflare-dns-sync.sh
RUN chmod +x /app/init.sh

# Give Example Crontab File
# RUN echo "# Example: \n# */10 * * * * /app/cloudflare-dns-sync.sh --domain sub1.domain.com" > /app/data/app.cron

# RUN crontab /app/data/app.cron

# Run cron in foreground on each container start
# If a specific file is set for the scheduled cronjobs, use it instead
CMD /app/init.sh
